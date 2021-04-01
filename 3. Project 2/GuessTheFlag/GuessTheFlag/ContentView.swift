//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Vinicius Maino.
//

import SwiftUI

struct FlagImage: View {
    let flag: String

    var body: some View {
        Image(flag)
            .renderingMode(.original)
            .clipShape(Capsule())
            .overlay(Capsule().stroke(Color.black, lineWidth: 1))
            .shadow(color: .white, radius: 2)
    }
}

struct AnimatedChallengeView: View {
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var userScore = 0
    
    @State private var flagAngle = [0.0, 0.0, 0.0]
    @State private var flagOpacity = [1.0, 1.0, 1.0]
    @State private var flagBlur: [CGFloat] = [0, 0, 0]
    
    var body: some View {
        
        ZStack {
            
            LinearGradient(gradient: Gradient(colors: [.black, .gray]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 30) {
                
                VStack {
                    Text("Tap on the flag of")
                        .foregroundColor(.white)
                    
                    Text("\(countries[correctAnswer])")
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                
                ForEach(0..<3) { number in
                    Button(action: {
                        self.flagTapped(number)
                    }, label: {
                        FlagImage(flag: self.countries[number])
                            .rotation3DEffect(.degrees(self.flagAngle[number]), axis: (x: 0, y: 1, z: 0))
                            .opacity(self.flagOpacity[number])
                            .blur(radius: self.flagBlur[number])
                            .animation(.default)
                    })
                }
                
                VStack {
                    
                    Text("Score: \(userScore)")
                        .foregroundColor(.white)
                        .font(.title)
                        .fontWeight(.medium)
                    
                    Text(scoreTitle)
                        .font(.title)
                        .fontWeight(.medium)
                        .foregroundColor(scoreTitle == "Correct answer!" ? Color.green : Color.red)
                }
                
                Spacer()
            }
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            userScore += 1
            scoreTitle = "Correct answer!"
            correctAnimation()
        } else {
            scoreTitle = "Wrong! That's the flag of \(countries[number])"
            
            if userScore != 0 {
                userScore -= 1
            }
            wrongAnimation()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            askQuestion()
        }
        
    }
    
    func askQuestion() {
        flagAngle = [0.0, 0.0, 0.0]
        flagOpacity = [1.0, 1.0, 1.0]
        flagBlur = [0, 0, 0]
        scoreTitle = ""
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func correctAnimation() {
        for flag in 0...2 {
            if flag == correctAnswer {
                flagAngle[flag] = 360.0
            } else {
                flagOpacity[flag] = 0.25
            }
        }
    }

    func wrongAnimation() {
        for flag in 0...2 {
            if flag != correctAnswer {
                flagBlur[flag] = 6
            }
        }
    }
}

struct AnimatedChallengeView_Previews: PreviewProvider {
    static var previews: some View {
        AnimatedChallengeView()
    }
}


