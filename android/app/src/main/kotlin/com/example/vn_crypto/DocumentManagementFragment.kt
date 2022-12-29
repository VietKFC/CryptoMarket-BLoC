package com.example.vn_crypto

import android.content.Context
import android.content.Intent
import android.os.Bundle
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.activity.result.contract.ActivityResultContracts
import androidx.fragment.app.Fragment

class DocumentManagementFragment : Fragment() {

    private val addFileContract = object :
        ActivityResultContracts.OpenDocument() {
        override fun createIntent(
            context: Context,
            input: Array<String>
        ): Intent {
            return super.createIntent(context, input)
                .addCategory(Intent.CATEGORY_OPENABLE)
                .addFlags(Intent.FLAG_GRANT_PERSISTABLE_URI_PERMISSION)
                .addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION)
        }
    }

    private val addFileLauncher =
        registerForActivityResult(addFileContract) { uri ->
            uri?.let {
                Log.e("viet", "launcher: " + uri.host)
                MainActivity.uriReceiverChannel?.invokeMethod(
                    RECEIVE_PATH_CHANNEL_KEY, uri.path
                )
                activity?.finish()
            }
        }

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        return inflater.inflate(
            R.layout.fragment_document_layout,
            container,
            false
        )
    }

    override fun onViewCreated(
        view: View,
        savedInstanceState: Bundle?
    ) {
        super.onViewCreated(view, savedInstanceState)
        addFileLauncher.launch(arrayOf(MIME_IMAGE))
    }

    companion object {
        private const val MIME_IMAGE = "image/*"
        const val RECEIVE_PATH_CHANNEL_KEY =
            "flutter/plugins/path_image"
    }
}