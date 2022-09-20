package com.leastauthority.destiny

import android.content.ContentResolver
import android.net.Uri
import android.provider.OpenableColumns
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import java.io.File

class Metadata(val fileName: String, val parentPath: String, val fileSize: Long)

class FileIOHandler {
    private val pendingReaders: MutableMap<Uri, UriReader> = HashMap()
    private val pendingWriters: MutableMap<Uri, UriWriter> = HashMap()

    private val FILE_IO_CHANNEL_NAME = "destiny.android/file_io"

    private val UNKNOWN_METHOD = "1"
    private val READ_FAILURE = "2"
    private val CLOSE_FAILURE = "3"
    private val WRITE_FAILURE = "4"

    private var contentResolver: ContentResolver? = null

    fun configureFlutterEngine(flutterEngine: FlutterEngine, contentResolver: ContentResolver) {
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            FILE_IO_CHANNEL_NAME
        ).setMethodCallHandler { call, result ->
            when (call.method) {
                "get_metadata" -> getMetadata(call, result)
                "read_bytes" -> readBytes(call, result)
                "close_reader" -> closeReader(call, result)
                "write_bytes" -> writeBytes(call, result)
                "close_writer" -> closeWriter(call, result)
                else -> result.error(
                    UNKNOWN_METHOD,
                    "Unknown method called on file picker: ${call.method}",
                    ""
                )
            }
        }
        this.contentResolver = contentResolver
    }

    fun createReader(contentResolver: ContentResolver, uri: Uri): UriReader? {
        pendingReaders[uri] = UriReader(contentResolver, uri)
        return pendingReaders[uri]
    }

    fun createWriter(contentResolver: ContentResolver, uri: Uri): UriWriter? {
        pendingWriters[uri] = UriWriter(contentResolver, uri)
        return pendingWriters[uri]
    }

    private fun getMetadata(call: MethodCall, result: MethodChannel.Result) {
        val uri = Uri.parse(
            call.argument<String>("uri") ?: throw java.lang.RuntimeException("Missing URI for read")
        )

        val metadata = getMetadata(uri)

        var l = java.util.ArrayList<Object>(2)

        l.add(metadata.fileName as Object)
        l.add(metadata.parentPath as Object)
        l.add(metadata.fileSize as Object)

        result.success(l)
    }

    private fun readBytes(call: MethodCall, result: MethodChannel.Result) {
        val uri = Uri.parse(
            call.argument<String>("uri") ?: throw java.lang.RuntimeException("Missing URI for read")
        )
        val maxBytes = call.argument<Int>("max")
            ?: throw java.lang.RuntimeException("Missing max bytes for read")

        try {
            result.success(read(uri, maxBytes).toList())
        } catch (error: Exception) {
            result.error(READ_FAILURE, error.message, "");
        }
    }

    private fun closeReader(call: MethodCall, result: MethodChannel.Result) {
        val uri = Uri.parse(
            call.argument<String>("uri") ?: throw java.lang.RuntimeException("Missing URI for read")
        )

        try {
            closeReader(uri)
            result.success(null)
        } catch (error: Exception) {
            result.error(CLOSE_FAILURE, error.message, "")
        }
    }

    private fun closeWriter(call: MethodCall, result: MethodChannel.Result) {
        val uri = Uri.parse(
            call.argument<String>("uri") ?: throw java.lang.RuntimeException("Missing URI for read")
        )

        try {
            closeWriter(uri)
            result.success(null)
        } catch (error: Exception) {
            result.error(CLOSE_FAILURE, error.message, "")
        }
    }

    private fun writeBytes(call: MethodCall, result: MethodChannel.Result) {
        val uri = Uri.parse(
            call.argument<String>("uri")
                ?: throw java.lang.RuntimeException("Missing URI for write")
        )

        val bytes = call.argument<ByteArray>("bytes")
            ?: throw java.lang.RuntimeException("Missing bytes for write")

        try {
            write(uri, bytes)
            result.success(null)
        } catch (error: Exception) {
            result.error(WRITE_FAILURE, error.message, "")
        }
    }

    private fun getMetadata(uri: Uri): Metadata {
        contentResolver?.query(uri, null, null, null, null)?.use { cursor ->
            val nameIndex = cursor.getColumnIndex(OpenableColumns.DISPLAY_NAME)
            val sizeIndex = cursor.getColumnIndex(OpenableColumns.SIZE)

            cursor.moveToFirst()

            val cleanedPath = {
                val directory =
                    uri.path?.split(File.separator)?.reversed()?.drop(1)?.reversed()
                        ?.joinToString(separator = File.separator)
                val parts = directory?.split(":")
                if (parts != null) {
                    if (parts?.size > 1) {
                        "${parts.drop(1).joinToString(separator = ":")}"
                    } else {
                        "$directory"
                    }
                } else directory
            }()

            val parentPath = when (uri.authority) {
                "com.android.externalstorage.documents" ->
                    "sdcard/$cleanedPath"
                "com.android.providers.downloads.documents" -> {
                    if (uri.path?.startsWith(prefix = "/document/raw:") == true) {
                        cleanedPath
                    } else {
                        "Downloads"
                    }
                }
                else -> cleanedPath
            }

            return Metadata(
                cursor.getString(nameIndex),
                parentPath ?: "Unknown location",
                cursor.getLong(sizeIndex)
            )
        }

        throw java.lang.RuntimeException("Failed to get metadata");
    }

    private fun closeReader(uri: Uri) {
        val reader = pendingReaders[uri]

        if (reader != null) {
            reader.close()
            pendingReaders.remove(uri)
        } else {
            throw java.lang.RuntimeException("No reader for URI: $uri")
        }
    }

    private fun closeWriter(uri: Uri) {
        val writer = pendingWriters[uri]
        if (writer != null) {
            writer.close()
            pendingWriters.remove(uri)
        } else {
            throw java.lang.RuntimeException("No writer for URI: $uri")
        }
    }

    private fun read(uri: Uri, maxBytes: Int): Pair<Int, ByteArray> {
        val reader = pendingReaders[uri]

        if (reader != null) {
            return reader.read(maxBytes)
        } else {
            throw java.lang.RuntimeException("No reader for URI: $uri")
        }
    }

    private fun write(uri: Uri, bytes: ByteArray) {
        val writer = pendingWriters[uri]
        if (writer != null) {
            return writer.write(bytes)
        } else {
            throw java.lang.RuntimeException("No writer for URI: $uri")
        }
    }
}