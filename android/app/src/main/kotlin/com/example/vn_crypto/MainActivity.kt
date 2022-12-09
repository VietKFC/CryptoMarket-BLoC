package com.example.vn_crypto

import android.content.Intent
import android.os.Bundle
import android.os.PersistableBundle
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            DOCUMENT_CHANNEL_KEY
        ).setMethodCallHandler { call, result ->
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

    companion object {
        private const val DOCUMENT_CHANNEL_KEY =
            "flutter/plugins/open_document"
    }
}
