import SwiftUI

struct DiceView: View {
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: DiceHistory.entity(), sortDescriptors: []) var history: FetchedResults<DiceHistory>
    
    @State private var diceSides = [4, 6, 10, 12, 20, 100]
    @State private var selectedDice = 4
    @State private var numberOfDices = 1...6
    @State private var selectedNumber = 1
    
    @State private var result: [String] = []
    
    var body: some View {

        NavigationView {
            Form {
                Section(header: Text("Number of sides")) {
                    Picker("Number of sides", selection: $selectedDice) {
                        ForEach(diceSides, id: \.self) {
                            Text("\($0)")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }

                Section(header: Text("Number of dices")) {
                    Picker("Number of sides", selection: $selectedNumber) {
                        ForEach(numberOfDices, id: \.self) {
                            Text("\($0)")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }

                Section(header: Text("Selection")) {
                    HStack{
                        Spacer()
                        Text(selectedNumber == 1 ? "\(selectedNumber) dice with \(selectedDice) sides will be rolled" : "\(selectedNumber) dices with \(selectedDice) sides will be rolled")
                        Spacer()
                    }

                }

                Section {
                    HStack {
                        Spacer()
                        Button(action:{
                            self.diceRoll()
                        }){
                          Text("Roll")
                        }
                        Spacer()
                    }
                }

                Section(header: Text("Result")) {
                    HStack(alignment: .center) {
                        Spacer()
                        ForEach(result, id: \.self) {
                            Text($0)
                        }
                        Spacer()
                    }
                }
            }
            .navigationTitle("Dice Roller")
        }
    }
    
    func simpleSuccess() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }

    
    func diceRoll() {
        
        result.removeAll()
        result.append("Rolling dices...")

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            result.removeAll()
            let newHistory = DiceHistory(context: self.moc)
            newHistory.date = Date()
            newHistory.id = UUID()
            for _ in 1 ... selectedNumber {
                let newRoll = Int.random(in: 1...selectedDice)                
                let newDice = DiceValues(context: self.moc)
                newDice.history = newHistory
                newDice.value = Int32(newRoll)
                
                result.append(String(newRoll))
            }

            self.simpleSuccess()
            try? self.moc.save()
        }
        
    }
}

struct DiceView_Previews: PreviewProvider {
    static var previews: some View {
        DiceView()
    }
}
