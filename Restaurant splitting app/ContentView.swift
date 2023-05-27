//
//  ContentView.swift
//  Restaurant splitting app
//
//  Created by User on 26/05/2023.
//

import SwiftUI

struct ContentView: View {
    
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    
    //swiftUI's @State property wrapper lets us modify our view structs freely, which means as our program changes we can update our view properties to match.
    
    
    let tipPercentages = Array(0..<101)
                               
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    var totalAllPersons: Double {
        _ = Double(numberOfPeople + 2) //_ was let peopleCountAll
        let tipSelectionAll = Double(tipPercentage)
        
        let tipValueAll = checkAmount / 100 * tipSelectionAll
        let grandTotalAll = checkAmount + tipValueAll
        
        return grandTotalAll
    }
    
    var body: some View {
        
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: currencyFormat())
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2 ..< 100) {
                            Text("\($0)people")
                        }
                    }
                }
                
                Section {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.menu)
                } header: {
                    Text("Select a percentage to leave a tip")
                }
                
                Section {
                    Text(totalAllPersons, format: currencyFormat())
                } header: {
                    Text("Total amount with tip")
                }
                
                Section {
                    Text(totalPerPerson, format: currencyFormat())
                } header: {
                    Text("Amount per person")
                }
            }
            .navigationTitle("weSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}
    
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }

let locale = Locale(identifier: "ka_GE")

func currencyFormat() -> FloatingPointFormatStyle<Double>.Currency {
    return .currency(code: locale.currency?.identifier ?? "GEL")
}

//And this is something that they would never ever use in georgia
///But still funny
