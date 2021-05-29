import SwiftUI

struct HistoryView: View {
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: DiceHistory.entity(), sortDescriptors: [NSSortDescriptor(key: "date", ascending: false)]) var history: FetchedResults<DiceHistory>
    
    var body: some View {
        NavigationView {
            List {
                ForEach(history, id: \.self) { hist in
                    HStack {
                        ForEach(hist.resultArray , id: \.self) { res in
                            Text("\(res.value)")
                        }
                    }
                }
            }
            .navigationTitle("History")
        }
    }
}

//struct HistoryView_Previews: PreviewProvider {
//    static var previews: some View {
//        HistoryView()
//    }
//}
