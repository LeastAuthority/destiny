package com.leastauthority.destiny

import android.content.ContentResolver
import android.net.Uri
import android.provider.OpenableColumns

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
