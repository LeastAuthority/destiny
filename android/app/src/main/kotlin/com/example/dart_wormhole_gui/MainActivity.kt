package com.example.dart_wormhole_gui

import android.Manifest
import android.content.ContentResolver
import android.content.Intent
import android.content.pm.PackageManager
import android.net.Uri
import android.provider.OpenableColumns
import android.util.Log
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val CHANNEL = "destiny.android/file_selector"
    private var pendingResult: MethodChannel.Result? = null
    private val FILE_SELECTOR_REQUEST = 1
    private val READ_PERMISSION_REQUEST = 2
    private val pendingReaders: MutableMap<Uri, UriReader> = HashMap()

    private val UNKNOWN_METHOD = "1"
    private val ALREADY_SELECTING = "2"
    private val NO_DATA = "3"
    private val PERMISSION_DENIED = "4"
    private val READ_FAILURE = "5"
    private val CLOSE_FAILURE = "6"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            CHANNEL
        ).setMethodCallHandler { call, result ->
            if (call.method == "select_file") selectFile(call, result)
            else if (call.method == "get_metadata") getMetadata(call, result)
            else if (call.method == "read_bytes") readBytes(call, result)
            else if (call.method == "close") close(call, result)
            else result.error(
                UNKNOWN_METHOD,
                "Unknown method called on file picker: ${call.method}",
                ""
            )
        }
    }

    private fun readBytes(call: MethodCall, result: MethodChannel.Result) {
        val uri = Uri.parse(
            call.argument<String>("uri") ?: throw java.lang.RuntimeException("Missing URI for read")
        )
        val maxBytes = call.argument<Int>("max")
            ?: throw java.lang.RuntimeException("Missing max bytes for read")

        if (!pendingReaders.containsKey(uri)) {
            throw java.lang.RuntimeException("No reader for URI: $uri")
        }

        try {
            result.success(pendingReaders[uri]?.read(maxBytes)?.toList())
        } catch (error: Exception) {
            result.error(READ_FAILURE, error.message, "");
        }
    }

    private fun close(call: MethodCall, result: MethodChannel.Result) {
        val uri = Uri.parse(
            call.argument<String>("uri") ?: throw java.lang.RuntimeException("Missing URI for read")
        )
        if (!pendingReaders.containsKey(uri)) {
            throw java.lang.RuntimeException("No reader for URI: $uri")
        }

        try {
            pendingReaders[uri]?.close()
            result.success(null)
            pendingReaders.remove(uri)
        } catch (error: Exception) {
            result.error(CLOSE_FAILURE, error.message, "")
        }
    }

    private fun getMetadata(call: MethodCall, result: MethodChannel.Result) {
        val uri = Uri.parse(
            call.argument<String>("uri") ?: throw java.lang.RuntimeException("Missing URI for read")
        )

        if (!pendingReaders.containsKey(uri)) {
            throw java.lang.RuntimeException("No reader for URI: $uri")
        }

        var l = java.util.ArrayList<Object>(2)

        l.add(pendingReaders.getValue(uri).fileName as Object)
        l.add(pendingReaders.getValue(uri).fileSize as Object)

        result.success(l)
    }

    private fun selectFile(call: MethodCall, result: MethodChannel.Result) {
        if (pendingResult != null) {
            result.error(ALREADY_SELECTING, "Already selecting a file", "");
        } else {
            pendingResult = result;
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
            pendingResult?.error(PERMISSION_DENIED, "Permission to read files not granted", "")
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
            Log.e("Destiny", data?.data.toString())
        }

        Log.e("Destiny", data?.extras.toString())
        if (pendingResult != null && data?.data != null) {
            val uri = data?.data as Uri
            Log.e("Destiny", contentResolver.getType(uri).toString())
            pendingReaders[uri] = UriReader(contentResolver, uri)
            pendingResult?.success(data?.data.toString());
        } else {
            pendingResult?.error(NO_DATA, "File selector did not return a URI", "bla")
        }

        pendingResult = null;
    }

    class UriReader(contentResolver: ContentResolver, uri: Uri) {
        private lateinit var _fileName: String
        var fileName: String
            get() = _fileName
            set(value) {
                throw RuntimeException("Nope")
            }

        private var _fileSize: Long = -1
        var fileSize: Long
            get() = _fileSize
            set(value) {
                throw RuntimeException("Nope")
            }

        private val stream = contentResolver.openInputStream(uri)
        private var buffer = ByteArray(16000)

        init {
            contentResolver.query(uri, null, null, null, null)?.use { cursor ->
                val nameIndex = cursor.getColumnIndex(OpenableColumns.DISPLAY_NAME)
                val sizeIndex = cursor.getColumnIndex(OpenableColumns.SIZE)
                cursor.moveToFirst()
                _fileName = cursor.getString(nameIndex)
                _fileSize = cursor.getLong(sizeIndex)
            }
        }

        fun read(max: Int): Pair<Int, ByteArray> {
            if (buffer.size <= max) {
                buffer = ByteArray(max)
            }
            val bytesReadCount = stream?.read(buffer)
                ?: throw RuntimeException("Read did not return a byte count")
            return Pair(bytesReadCount, buffer)
        }

        fun close() {
            (stream ?: throw RuntimeException("No stream")).close()
        }
    }
}
