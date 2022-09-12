package com.leastauthority.destiny

import android.content.ContentResolver
import android.net.Uri
import android.provider.OpenableColumns

class UriReader(contentResolver: ContentResolver, uri: Uri) {
    private val stream = contentResolver.openInputStream(uri)
    private var buffer = ByteArray(16000)

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
