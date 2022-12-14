package com.example.vn_crypto

import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity

class MainActivity2 : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main2)
        supportFragmentManager.beginTransaction()
            .add(
                R.id.fragmentContainerView,
                DocumentManagementFragment()
            )
            .commit()
    }
}