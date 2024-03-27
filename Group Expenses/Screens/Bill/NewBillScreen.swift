//
//  NewBillScreen.swift
//  Group Expenses
//
//  Created by Josue Ayala on 27/3/24.
//

import SwiftUI

struct NewBillScreen: View {
    
    @State private var selectedNames: Set<String> = []
    @State private var paidByModel: String?
    @State private var titleModel: String = ""
    @State private var quantityModel: Decimal?
    @State private var names = [
        "John Smith",
        "Emma Johnson",
        "Michael Williams",
        "Sophia Brown"
    ]
    
    let onCancel: () ->Void
    
    var body: some View {
        NavigationView {
            Form {
                Section("Bill Details") {
                    TextField("Title", text: $titleModel)
                    TextField("Quantity", value: $quantityModel, format: .currency(code: "USD")).keyboardType(.numberPad)
                    DatePicker(selection: .constant(Date()), displayedComponents: [.date], label: { Text("Date") }).datePickerStyle(.automatic)
                    Picker("Paid by", selection: $paidByModel) {
                        ForEach(names, id: \.self) {
                            name in Text("\(name)").tag(name)
                        }
                    }
                }
                
                Section("Split Between") {
                    ForEach(names, id: \.self) { name in
                        HStack {
                            Image(systemName: self.selectedNames.contains(name) ? "checkmark.circle.fill" : "circle")
                                .foregroundStyle(self.selectedNames.contains(name) ? Color.accentColor : .secondary)
                                .accessibility(label: Text(self.selectedNames.contains(name) ? "Checked" : "Unchecked"))
                                .imageScale(.large)
                            Text(name)
                            Spacer()
                            Text("$20.00")
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            if self.selectedNames.contains(name) {
                                self.selectedNames.remove(name)
                            } else {
                                self.selectedNames.insert(name)
                            }
                        }
                    }
                }
            }.formStyle(.automatic).navigationTitle("New Bill").navigationBarTitleDisplayMode(.inline).toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        onCancel()
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        
                    }
                }
            }
        }
    }
}

#Preview {
    NewBillScreen(onCancel: {
        print("On cancel...")
    })
}
