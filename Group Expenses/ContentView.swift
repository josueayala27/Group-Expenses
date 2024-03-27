//
//  ContentView.swift
//  Group Expenses
//
//  Created by Josue Ayala on 27/3/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            BillsScreen().tabItem {
                Label("Bills", systemImage: "newspaper")
            }
            BalanceSheetsScreen().tabItem {
                Label("Balance Sheets", systemImage: "arrow.left.arrow.right")
            }
        }
    }
}

#Preview {
    ContentView()
}
