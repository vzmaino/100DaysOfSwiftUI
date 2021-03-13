//
//  ContentView.swift
//  VolumeConverter
//
//  Created by Vinicius Maino.
//

import SwiftUI

struct ContentView: View {
    
    @State private var inputValue: String = ""
    @State private var unitInput: Int = 0
    @State private var unitOutput: Int = 0
    let units: [String] = [ "Milliliter", "Liter", "Cup", "Pint", "Gallon" ]
    
    var convertedValue: Double {
        var baseValue = Double(inputValue.replacingOccurrences(of: ",", with: ".")) ?? 0
        let unitIn = units[unitInput]
        let unitOut = units[unitOutput]
        
        switch unitIn {
        case "Liter":
            baseValue *= 1000
        case "Cup":
            baseValue *= 240
        case "Pint":
            baseValue *= 473.176
        case "Gallon":
            baseValue *= 3785.41
        default:
            baseValue *= 1
        }
        
        switch unitOut {
        case "Liter":
            baseValue /= 1000
        case "Cup":
            baseValue /= 240
        case "Pint":
            baseValue /= 473.176
        case "Gallon":
            baseValue /= 3785.41
        default:
            baseValue /= 1
        }
        
        return baseValue
    }
    
    var body: some View {
        
        NavigationView {
            Form {
                
                Section {
                    TextField("Input value", text: $inputValue)
                        .keyboardType(.decimalPad)
                }
                
                Section(header: Text("From")) {
                    Picker("Input unit", selection: $unitInput) {
                        ForEach(0..<units.count) {
                            Text("\(self.units[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("To")) {
                    Picker("Input unit", selection: $unitOutput) {
                        ForEach(0..<units.count) {
                            Text("\(self.units[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Converted value")) {
                    Text("\(convertedValue, specifier: "%g")")
                }
                
            }
            .navigationBarTitle("Volume Converter")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
