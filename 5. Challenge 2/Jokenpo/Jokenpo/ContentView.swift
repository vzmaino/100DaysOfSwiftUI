//
//  ContentView.swift
//  Jokenpo
//
//  Created by Vinicius Maino on 08/03/21.
//

import SwiftUI

struct ContentView: View {
    
    @State private var moves = ["✊", "✋", "✌️"]
    @State private var appSelectedMove = Int.random(in: 0...2)
    @State private var shouldWin = Bool.random()
    @State private var playerScore = 0
    @State private var showingAlert = false
    @State private var movesCount = 0
    
    var body: some View {
        
        ZStack {
            Color.gray
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 30) {
                
                Text("Rock Paper Scissors")
                    .foregroundColor(.black)
                    .font(.title)
                    .fontWeight(.medium)
                
                Text(shouldWin ? "You should win": "You should lose")
                    .foregroundColor(.black)
                    .font(.title2)
                    .fontWeight(.light)
                
                Text("\(moves[appSelectedMove])")
                    .font(.system(size: 150))
                
                Text("What's your move?")
                    .foregroundColor(.black)
                    .font(.title2)
                    .fontWeight(.light)
                
                HStack {
                    
                    ForEach(0..<3) { move in
                        Button(action: {
                            self.playerMove(move)
                        }, label: {
                            Text("\(moves[move])")
                                .font(.system(size: 80))
                        })
                    }
                    
                }
                
                Text("Score: \(playerScore)")
                    .foregroundColor(.black)
                    .font(.title)
                    .fontWeight(.medium)
                
            }.alert(isPresented: $showingAlert) {
                Alert(title: Text("Game over!"), message: Text("Your score is \(playerScore)"), dismissButton: .default(Text("Continue")) {
                    self.gameOver()
                })
            }
        }
    }
    
    func playerMove (_ number: Int) {
        
        //Draw case
        if number == appSelectedMove {
            movesCount += 1
            self.replay()
            return
        }
        
        //Win or lose cases
        switch number {
        case 0:
            if appSelectedMove == 1 {
                playerScore += !shouldWin ? 1 : -1
            } else {
                playerScore += shouldWin ? 1 : -1
            }
        case 1:
            if appSelectedMove == 2 {
                playerScore += !shouldWin ? 1 : -1
            } else {
                playerScore += shouldWin ? 1 : -1
            }
        case 2:
            if appSelectedMove == 0 {
                playerScore += !shouldWin ? 1 : -1
            } else {
                playerScore += shouldWin ? 1 : -1
            }
        default:
            print("error")
        }
        
        movesCount += 1
        
        //Game over check
        if movesCount < 10 {
            self.replay()
        } else {
            showingAlert = true
        }
    }
    
    func replay() {
        appSelectedMove = Int.random(in: 0...2)
        shouldWin = Bool.random()
    }
    
    func gameOver() {
        movesCount = 0
        playerScore = 0
        appSelectedMove = Int.random(in: 0...2)
        shouldWin = Bool.random()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
