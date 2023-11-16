package com.stevdza.mobiledemo.android.home

import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.material3.CircularProgressIndicator
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.dp
import androidx.lifecycle.viewmodel.compose.viewModel
import com.stevdza.mobiledemo.android.ProductCard

@Composable
fun HomeScreen() {
    val viewModel: HomeViewModel = viewModel()
    val requestState by viewModel.requestState

    if (requestState.isLoading()) {
        Box(
            modifier = Modifier
                .fillMaxSize()
                .background(MaterialTheme.colorScheme.surface),
            contentAlignment = Alignment.Center
        ) {
            CircularProgressIndicator()
        }
    } else if (requestState.isSuccess()) {
        LazyColumn(
            modifier = Modifier
                .background(MaterialTheme.colorScheme.surface)
                .padding(horizontal = 20.dp),
            verticalArrangement = Arrangement.spacedBy(20.dp)
        ) {
            items(
                items = requestState.getProducts().items,
                key = { it.id }
            ) {
                ProductCard(product = it)
            }
        }
    } else if (requestState.isError()) {
        Box(
            modifier = Modifier
                .fillMaxSize()
                .background(MaterialTheme.colorScheme.surface)
                .padding(all = 24.dp),
            contentAlignment = Alignment.Center
        ) {
            Text(
                text = requestState.getErrorMessage(),
                textAlign = TextAlign.Center
            )
        }
    }
}