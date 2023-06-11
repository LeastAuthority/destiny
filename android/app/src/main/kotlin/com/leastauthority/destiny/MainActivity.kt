package com.leastauthority.destiny

import android.Manifest
import android.content.Intent
import android.content.pm.PackageManager
import android.net.Uri
import android.os.Bundle
import android.os.Handler
import android.os.Looper
import android.os.UserManager
import android.util.Log
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val FILE_SELECTOR_CHANNEL_NAME = "destiny.android/file_selector"
    private val SHARE_FILE_CHANNEL_NAME = "destiny.androids/share_file"
    private val SAVE_AS_CHANNEL_NAME = "destiny.android/save_as"
    private val USER_ID_CHANNEL_NAME = "destiny.android/user_id"

    private var SHARE_FILE_CHANNEL: MethodChannel? = null

    private var pendingSelectFileResult: MethodChannel.Result? = null
    private var pendingSaveAsResult: MethodChannel.Result? = null
    private val fileIOHandler = FileIOHandler()

    private val FILE_SELECTOR_REQUEST = 1
    private val READ_PERMISSION_REQUEST = 2
    private val SAVE_AS_REQUEST = 3

    private val UNKNOWN_METHOD = "1"
    private val ALREADY_SELECTING = "2"
    private val NO_DATA = "3"
    private val PERMISSION_DENIED = "4"

    private val LOG_TAG = "Destiny";

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        if (intent?.action == Intent.ACTION_SEND) {
            sendFileFromIntent(intent);
        }
    }

    // Get emphmeral user id to be used in accessing a directory name
    private fun getUserID(call: MethodCall, result: MethodChannel.Result) {
        val userManager = getContext().getSystemService(UserManager::class.java)
        
        val ephemeralUserId = userManager!!.getSerialNumberForUser(android.os.Process.myUserHandle())
        result.success(ephemeralUserId);
    }

    private fun sendFileFromIntent(intent: Intent) {
        val uri = intent.getParcelableExtra<Uri>(Intent.EXTRA_STREAM) as Uri
        if (SHARE_FILE_CHANNEL != null) {
            fileIOHandler.createReader(contentResolver, uri)
            Handler(Looper.getMainLooper()).post {
                SHARE_FILE_CHANNEL?.invokeMethod("share_file", uri.toString())
            }
        } else {
            Log.e(LOG_TAG, "Share file channel not set")
        }
    }

    private fun saveAs(call: MethodCall, result: MethodChannel.Result) {
        val initialName = call.argument<String>("filename")
        val saveAsIntent = Intent()
            .setType("application/octet-stream")
            .setAction(Intent.ACTION_CREATE_DOCUMENT)
            .addCategory(Intent.CATEGORY_OPENABLE)
            .putExtra(Intent.EXTRA_TITLE, initialName)
        startActivityForResult(
            Intent.createChooser(saveAsIntent, "Save as"),
            SAVE_AS_REQUEST
        )

        pendingSaveAsResult = result
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            FILE_SELECTOR_CHANNEL_NAME
        ).setMethodCallHandler { call, result ->
            when (call.method) {
                "select_file" -> selectFile(call, result)
                else -> result.error(
                    UNKNOWN_METHOD,
                    "Unknown method called on file picker: ${call.method}",
                    ""
                )
            }
        }

        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            SAVE_AS_CHANNEL_NAME
        ).setMethodCallHandler { call, result ->
            when (call.method) {
                "save_as" -> saveAs(call, result)
                else -> result.error(
                    UNKNOWN_METHOD,
                    "Unknown method called on save as channel: ${call.method}",
                    ""
                )
            }
        }

        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger, 
            USER_ID_CHANNEL_NAME
        ).setMethodCallHandler { call, result -> 
            when (call.method) {
                "getUserID" -> getUserID(call, result)
                else -> result.error(
                    UNKNOWN_METHOD,
                    "Unknown method called on save as channel: ${call.method}",
                    ""
                )
            }
        }

        SHARE_FILE_CHANNEL =
            MethodChannel(flutterEngine.dartExecutor.binaryMessenger, SHARE_FILE_CHANNEL_NAME)

        fileIOHandler.configureFlutterEngine(flutterEngine, contentResolver)
    }

    private fun selectFile(call: MethodCall, result: MethodChannel.Result) {
        if (pendingSelectFileResult != null) {
            result.error(ALREADY_SELECTING, "Already selecting a file", "");
        } else {
            pendingSelectFileResult = result;
            if (!hasPermission()) {
                ActivityCompat.requestPermissions(
                    this,
                    arrayOf(Manifest.permission.READ_EXTERNAL_STORAGE),
                    READ_PERMISSION_REQUEST
                );
            } else {
                startFileSelector()
            }
        }
    }

    private fun startFileSelector() {
        val selectFileIntent = Intent()
            .setType("*/*")
            .setAction(Intent.ACTION_GET_CONTENT)
            .addCategory(Intent.CATEGORY_OPENABLE)
            .putExtra(Intent.EXTRA_LOCAL_ONLY, true)
            .setFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION);
        startActivityForResult(
            Intent.createChooser(selectFileIntent, "Select a file"),
            FILE_SELECTOR_REQUEST
        )
    }

    override fun onRequestPermissionsResult(
        requestCode: Int,
        permissions: Array<out String>,
        grantResults: IntArray
    ) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults)
        if (requestCode == READ_PERMISSION_REQUEST && grantResults[0] == PackageManager.PERMISSION_GRANTED) {
            startFileSelector()
        } else {
            pendingSelectFileResult?.error(
                PERMISSION_DENIED,
                "Permission to read files not granted",
                ""
            )
        }
    }

    private fun hasPermission() =
        ContextCompat.checkSelfPermission(
            context,
            Manifest.permission.READ_EXTERNAL_STORAGE,
        ) == PackageManager.PERMISSION_GRANTED

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        if (requestCode == FILE_SELECTOR_REQUEST) {
            Log.e(LOG_TAG, data?.data.toString())

            Log.e(LOG_TAG, data?.extras.toString())
            if (pendingSelectFileResult != null && data?.data != null) {
                val uri = data?.data as Uri
                Log.e(LOG_TAG, contentResolver.getType(uri).toString())
                fileIOHandler.createReader(contentResolver, uri)
                pendingSelectFileResult?.success(data?.data.toString());
            } else {
                pendingSelectFileResult?.error(NO_DATA, "File selector did not return a URI", "")
            }

            pendingSelectFileResult = null;
        } else if (requestCode == SAVE_AS_REQUEST) {
            if (pendingSaveAsResult != null && data?.data != null) {
                val uri = data?.data as Uri
                fileIOHandler.createWriter(contentResolver, uri)
                pendingSaveAsResult?.success(data?.data.toString());
            } else {
                pendingSaveAsResult?.error(NO_DATA, "Save as dialog did not return a URI", "")
            }

        }

    }

}
