package com.leastauthority.destiny

import android.content.ContentResolver
import android.net.Uri
import java.io.OutputStream

class UriWriter(contentResolver: ContentResolver, private val uri: Uri) {
    private val stream: OutputStream?

    init {
        stream = contentResolver.openOutputStream(uri)
    }

    fun write(bytes: ByteArray) {
        if (stream != null) {
            stream.write(bytes)
        } else {
            throw java.lang.RuntimeException("No output stream set for writer for $uri")

        }
    }

    fun close() {
        if (stream != null) {
            stream.close()
        } else {
            throw java.lang.RuntimeException("No output stream set for writer for $uri")
        }
    }
}