//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Vinicius Maino on 08/04/21.
//

import SwiftUI

//challenge 3
enum ResortSorting {
    case Default, Alphabetical, Country
}

enum ResortFilters {
    case Small, Average, Large, All
}


struct ContentView: View {
    
    @ObservedObject var favorites = Favorites()
    
    let resorts: [Resort] = Bundle.main.decode("resorts.json")
    
    //challenge 3
    @State private var filteredResorts = [Resort]()
        
    @State private var showingFilters = false
    @State private var showingSort = false
    
    @State private var selectedFilter = 0
    @State private var sorted: ResortSorting = .Default
    
    var body: some View {
        NavigationView {
            List(filteredResorts) { resort in
                NavigationLink(destination: ResortView(resort: resort)) {
                    
//                    Image(resort.country)
//                        .resizable()
//                        .scaledToFill()
//                        .frame(width: 40, height: 25)
//                        .clipShape(
//                            RoundedRectangle(cornerRadius: 5)
//                        )
//                        .overlay(
//                            RoundedRectangle(cornerRadius: 5)
//                                .stroke(Color.black, lineWidth: 1)
//                        )
//
//                    VStack(alignment: .leading) {
//                        Text(resort.name)
//                            .font(.headline)
//                        Text("\(resort.runs) runs")
//                            .foregroundColor(.secondary)
//                    }
//                    .layoutPriority(1)
                    
                    //challenge 3
                    VStack(alignment: .leading) {
                        Text(resort.name)
                            .font(.headline)
                            .actionSheet(isPresented: self.$showingFilters) {
                                ActionSheet(title: Text("Filter by size:"), buttons: [
                                    .default(Text("Small")) {
                                        self.selectedFilter = 1
                                        self.filterAndSort()
                                    },
                                    .default(Text("Average")) {
                                        self.selectedFilter = 2
                                        self.filterAndSort()
                                    },
                                    .default(Text("Large")) {
                                        self.selectedFilter = 3
                                        self.filterAndSort()
                                    },
                                    .default(Text("All")) {
                                        self.selectedFilter = 0
                                        self.filterAndSort()
                                    },
                                    .cancel()
                                ])
                            }
                        Text("\(resort.runs) runs")
                            .foregroundColor(.secondary)
                            .actionSheet(isPresented: self.$showingSort) {
                                ActionSheet(title: Text("Sort by:"), buttons: [
                                    .default(Text("Default")) {
                                        self.sorted = .Default
                                        self.filterAndSort()
                                    },
                                    .default(Text("Alphabetical")) {
                                        self.sorted = .Alphabetical
                                        self.filterAndSort()
                                    },
                                    .default(Text("Country")) {
                                        self.sorted = .Country
                                        self.filterAndSort()
                                    },
                                    .cancel()
                                ])
                            }
                    }
                    
                    if self.favorites.contains(resort) {
                        Spacer()
                        Image(systemName: "heart.fill")
                        .accessibility(label: Text("This is a favorite resort"))
                            .foregroundColor(.red)
                    }
                }
            }
            //challenge 3
            .onAppear(perform: {
                self.filteredResorts = self.resorts
            })
            .navigationBarTitle("Resorts")
            .navigationBarItems(
                leading:
                Button(action: {
                    self.showingSort.toggle()
                }) {
                    Image(systemName: "arrow.up.arrow.down.circle")
                        .padding(5)
                        .background(Color.clear)
                        .clipShape(Circle())
                },
                trailing:
                Button(action: {
                    self.showingFilters.toggle()
                }) {
                    Image(systemName: "line.horizontal.3.decrease.circle")
                        .padding(5)
                        .background(Color.clear)
                        .clipShape(Circle())
                }
            )
            .navigationBarTitle("Resorts")
            
            WelcomeView()
        }
        .environmentObject(favorites)
        .phoneOnlyStackNavigationView()
    }
    
    //challenge 3
    func filterAndSort() {
        switch sorted {
            case .Default:
                filteredResorts = resorts
            case .Alphabetical:
                filteredResorts = resorts.sorted(by: { $0.name < $1.name })
            case .Country:
                filteredResorts = resorts.sorted(by: { $0.country < $1.country })
        }
        
        if selectedFilter > 0 {
            filteredResorts = filteredResorts.filter { $0.size == selectedFilter }
        }
    }
}

extension View {
    func phoneOnlyStackNavigationView() -> some View {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return AnyView(self.navigationViewStyle(StackNavigationViewStyle()))
        } else {
            return AnyView(self)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
