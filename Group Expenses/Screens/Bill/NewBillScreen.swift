//
//  NewBillScreen.swift
//  Group Expenses
//
//  Created by Josue Ayala on 27/3/24.
//

import SwiftUI

struct PeopleModel: Identifiable, Hashable {
    var id: UUID = UUID()
    var fullName: String
    var amount: Decimal
    var isIncluded: Bool
    
    //    Computed property
    var formattedAmount: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = "$"
        return formatter.string(from: NSDecimalNumber(decimal: amount)) ?? ""
    }
}

struct NewBillScreen: View {
    @State private var titleModel: String = ""
    @State private var quantityModel: Decimal?
    @State private var people: [PeopleModel] = [
        PeopleModel(fullName: "John Smith", amount: 0, isIncluded: true),
        PeopleModel(fullName: "Emma Johnson", amount: 0, isIncluded: true),
        PeopleModel(fullName: "Michael Williams", amount: 0, isIncluded: true),
        PeopleModel(fullName: "Sophia Brown", amount: 0, isIncluded: true)
    ]
    @State private var paidByModel: PeopleModel?
    
    let onCancel: () ->Void
    
    var splitBills: Void {
        let totalOfIncludedPeople = people.filter({ $0.isIncluded }).count
        
        for index in people.indices {
            if people[index].isIncluded {
                people[index].amount = quantityModel! / Decimal(totalOfIncludedPeople)
            }
        }
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section("Bill Details") {
                    TextField("Title", text: $titleModel)
                    
                    TextField("Quantity", value: $quantityModel, format: .currency(code: "USD")).keyboardType(.numberPad).onSubmit {
                        splitBills
                    }
                    
                    DatePicker(selection: .constant(Date()), displayedComponents: [.date], label: { Text("Date") }).datePickerStyle(.automatic)
                    
                    Picker("Paid by", selection: $paidByModel) {
                        ForEach(people, id: \.self) {
                            person in Text("\(person.fullName)").tag(person as PeopleModel).tag(person)
                        }
                    }
                }
                
                Section("Split Between") {
                    ForEach(Array(people.enumerated()), id: \.element) { index, person in
                        HStack {
                            Image(systemName: person.isIncluded ? "checkmark.circle.fill" : "circle")
                                .foregroundStyle(person.isIncluded ? Color.accentColor : .secondary)
                                .imageScale(.large)
                            Text("\(person.fullName)")
                            Spacer()
                            Text("\(person.formattedAmount)")
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            people[index].isIncluded.toggle()
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
