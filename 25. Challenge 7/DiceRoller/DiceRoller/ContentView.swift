import SwiftUI
import CoreData

struct ContentView: View {
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: DiceHistory.entity(), sortDescriptors: []) var history: FetchedResults<DiceHistory>
    
    var body: some View {
        TabView {
            DiceView()
                .tabItem {
                    Image(systemName: "square.grid.2x2.fill")
                }
            HistoryView()
                .tabItem {
                    Image(systemName: "square.stack.fill")
                }
        }
    }

}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
