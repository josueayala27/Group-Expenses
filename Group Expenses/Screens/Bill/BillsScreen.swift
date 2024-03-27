//
//  BillsScreen.swift
//  Group Expenses
//
//  Created by Josue Ayala on 27/3/24.
//

import SwiftUI

struct BillsScreen: View {
    @State private var isNewBillSheet: Bool = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(["Bill 1", "Bill 2"], id: \.self) {
                    bill in NavigationLink {
                        Text("\(bill)")
                    } label: {
                        HStack {
                            VStack(alignment: .leading) {
                                Text("Bill Title").font(.headline)
                                Text("It has been paid for by ").font(.caption).foregroundStyle(.gray) + Text("Josué Ayala").font(.caption).foregroundStyle(.black)
                            }
                            Spacer()
                            Text("$200.00").font(.subheadline)
                        }
                    }
                }.onDelete(perform: { indexSet in
                    print(indexSet)
                })
            }.navigationTitle("Bills").navigationBarTitleDisplayMode(.large).listStyle(.inset).toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        isNewBillSheet.toggle()
                    }, label: {
                        Image(systemName: "plus")
                    }).sheet(isPresented: $isNewBillSheet, content: {
                        NewBillScreen(onCancel: {
                            isNewBillSheet.toggle()
                        })
                    })
                }
            }
        }
    }
}

#Preview {
    BillsScreen()
}
