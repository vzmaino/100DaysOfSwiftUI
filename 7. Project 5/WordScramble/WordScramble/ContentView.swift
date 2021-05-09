//
//  ContentView.swift
//  WordScramble
//
//  Created by Vinicius Maino.
//

import SwiftUI

struct ContentView: View {
    
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
    @State private var userScore = 0
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                
                TextField("Enter your word", text: $newWord, onCommit: addNewWord)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                    .padding()
                
                // Project 18 - Challenge 2 & 3
                GeometryReader { listProxy in
                    List(self.usedWords, id: \.self) { word in
                        GeometryReader { itemProxy in
                            HStack {
                                Image(systemName: "\(word.count).circle")
                                    // Project 18 - Challenge 3
                                    .foregroundColor(self.getColor(listProxy: listProxy, itemProxy: itemProxy))
                                Text(word)
                            }
                            // Project 18 - Challenge 2
                            .frame(width: itemProxy.size.width, alignment: .leading)
                            .offset(x: self.getOffset(listProxy: listProxy, itemProxy: itemProxy), y: 0)
                        }
                    }
                }
                
                Spacer()
                
                VStack {
                    Text("Score: \(userScore)")
                        .font(.title)
                        .padding()
                }
            }
            .navigationBarTitle(rootWord)
            .navigationBarItems(trailing: Button(action: startGame) {
                Text("New word")
            })
            .onAppear(perform: startGame)
            .alert(isPresented: $showingError) {
                Alert(title: Text(errorTitle), message: Text(errorMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
    
    // Project 18 - Challenge 2
    func getOffset(listProxy: GeometryProxy, itemProxy: GeometryProxy) -> CGFloat {
        let listHeight = listProxy.size.height
        let listStart = listProxy.frame(in: .global).minY
        let itemStart = itemProxy.frame(in: .global).minY

        let itemPercent =  (itemStart - listStart) / listHeight * 100

        let thresholdPercent: CGFloat = 60
        let indent: CGFloat = 9

        if itemPercent > thresholdPercent {
            return (itemPercent - (thresholdPercent - 1)) * indent
        }

        return 0
    }
    
    // Project 18 - Challenge 3
    func getColor(listProxy: GeometryProxy, itemProxy: GeometryProxy) -> Color {
        let itemPercent = getItemPercent(listProxy: listProxy, itemProxy: itemProxy)

        let colorValue = Double(itemPercent / 100)

        // varying from green to red going through yellow,
        // using Color(red:green:blue:) as suggested
        return Color(red: 2 * colorValue, green: 2 * (1 - colorValue), blue: 0)

        // varying hue is easier to work with and offers more variety though
        //return Color(hue: colorValue, saturation: 0.9, brightness: 0.9)
    }

    // Project 18 - Challenge 3
    func getItemPercent(listProxy: GeometryProxy, itemProxy: GeometryProxy) -> CGFloat {
        let listHeight = listProxy.size.height
        let listStart = listProxy.frame(in: .global).minY
        let itemStart = itemProxy.frame(in: .global).minY

        let itemPercent =  (itemStart - listStart) / listHeight * 100

        return itemPercent
    }
    
    func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard answer.count > 0 else {
            return
        }

        guard isOriginal(word: answer) else {
            wordError(title: "Word used already.", message: "Be more original!")
            return
        }
        
        guard isPossible(word: answer) else {
            wordError(title: "Word not recognized.", message: "You cant just make them up, you know!")
            return
        }
        
        guard isReal(word: answer) else {
            wordError(title: "Word not possible.", message: "That isn't a real word!")
            return
        }
        
        usedWords.insert(answer, at: 0)
        userScore += answer.count
        newWord = ""
    }
    
    func startGame() {
        usedWords = [String]()
        userScore = 0
        
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            
            if let startWords = try? String(contentsOf: startWordsURL) {
                
                let allWords = startWords.components(separatedBy: "\n")
                rootWord = allWords.randomElement() ?? "silkworm"
                
                return
            }
        }
        
        fatalError("Could not load start.txt from bundle.")
    }
    
    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }
    
    func isPossible(word: String) -> Bool {
        var tempWord = rootWord
        
        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }
        
        return true
    }
    
    func isReal(word: String) -> Bool {
        if word.count < 3 {
            return false
        }
        
        if word == rootWord {
            return false
        }
        
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return misspelledRange.location == NSNotFound
    }
    
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
