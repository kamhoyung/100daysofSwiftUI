//
//  ContentView.swift
//  WeSplit
//
//  Created by Kamho Yung on 15/05/2024.
//

import SwiftUI

struct ContentView: View {
    //default value for these data points
    @State private var checkAmount : Double = 0.0
    @State private var numberOfPeople : Int = 2
    @State private var tipPercentage : Int = 20
    @FocusState private var amountIsFocused : Bool
    
    let tipPercentages : [Int] = [10,15,20,25,0]
    var totalPerPerson : Double {
        let peopleCount = Double(numberOfPeople+2)
        let tipSelection = Double(tipPercentage)
        let tipValue = checkAmount/100 * tipSelection
        let totalAmount = tipValue + checkAmount
        return totalAmount / peopleCount
    }
    
    var body: some View {
        NavigationStack{
            Form {
                Section {
                    TextField("Amount", value: $checkAmount , format: .currency(code: Locale.current.currency?.identifier ?? "DKK"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Among", selection: $numberOfPeople){
                        ForEach(2..<51) {
                            Text("\($0) people")
                        }
                    }
                }
                Section("Tip amount"){
                    Picker("Tip Percentage", selection: $tipPercentage) {
                        ForEach(0..<101) {
                            Text("\($0) %")
                        }
                    }
                    .pickerStyle(.wheel)
                }
                Section("Grand total"){
                    Text(totalPerPerson * Double(numberOfPeople+2), format: .currency(code: Locale.current.currency?.identifier ?? "DKK"))
                }
                Section("Total amount per person"){
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "DKK"))
                }
                
            }
            .navigationTitle("WeSplit")
            .toolbar {
                if amountIsFocused {
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
        
}

#Preview {
    ContentView()
}
