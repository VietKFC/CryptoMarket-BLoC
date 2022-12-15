package com.example.vn_crypto

import android.content.Intent
import android.os.Bundle
import android.os.PersistableBundle
import androidx.annotation.NonNull
import com.example.vn_crypto.DocumentManagementFragment.Companion.RECEIVE_PATH_CHANNEL_KEY
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {

    private val openDocumentChannel by lazy {
        flutterEngine?.dartExecutor?.binaryMessenger?.let {
            MethodChannel(
                it,
                DOCUMENT_CHANNEL_KEY
            )
        }
    }

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        uriReceiverChannel =
            flutterEngine.dartExecutor.binaryMessenger.let {
                MethodChannel(
                    it,
                    RECEIVE_PATH_CHANNEL_KEY
                )
            }
        openDocumentChannel?.setMethodCallHandler { call, result ->
            startActivity(
                Intent(
                    this,
                    MainActivity2::class.java
                )
            )
        }
    }

    override fun onCreate(
        savedInstanceState: Bundle?,
        persistentState: PersistableBundle?
    ) {
        super.onCreate(savedInstanceState, persistentState)
        setContentView(R.layout.activity_main)
    }

    override fun detachFromFlutterEngine() {
        super.detachFromFlutterEngine()
        uriReceiverChannel?.setMethodCallHandler(null)
        openDocumentChannel?.setMethodCallHandler(null)
    }

    companion object {
        private const val DOCUMENT_CHANNEL_KEY =
            "flutter/plugins/open_document"
        var uriReceiverChannel: MethodChannel? = null
    }
}
