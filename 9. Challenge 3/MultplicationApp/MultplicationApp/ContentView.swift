//
//  ContentView.swift
//  MultplicationApp
//
//  Created by Vinicius Maino.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isPlaying = false
    @State private var selectedTable = 1
    @State private var questionsToAnswer = 0
    @State private var totalQuestions = 0
    @State private var currentQuestion = 0
    @State private var playerAnswer = ""
    @State private var playerScore = 0
    @State private var showingScore = false
    
    @State private var questions = [Question]()
    @State private var imagesName = ["duck", "dog", "rabbit", "whale", "rhino", "elephant", "zebra",  "cow", "panda", "hippo", "gorilla", "owl", "penguin", "sloth", "frog", "monkey", "giraffe", "pig", "snake", "bear", "chick", "crocodile"]
    
    let tables = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
    let numberOfQuestions = ["5", "10", "20", "All"]
    
    @State private var buttonAngle = 0.0
    @State private var buttonBlur: CGFloat = 0
    
    var body: some View {
        
        Group {
            
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.red, .orange, .yellow, .green, .blue, .purple]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                
                if !isPlaying {
                    VStack {
                        
                        Text("Multiply Game")
                            .font(.largeTitle)
                            .bold()
                            .padding()
                        
                        Section(header: Text("How many questions do you want to try?").font(.headline)) {
                            Picker("Question", selection: $questionsToAnswer) {
                                ForEach(0 ..< numberOfQuestions.count) {
                                    Text("\(self.numberOfQuestions[$0])")
                                }
                            }
                            .pickerStyle(SegmentedPickerStyle())
                            .padding()
                        }
                        
                        Text("And up to what table?").font(.headline)
                        
                        HStack {
                            ForEach(0..<6) { number in
                                Button(action: {
                                    selectedTable = number+1
                                }, label: {
                                    VStack {
                                        Image(imagesName[number])
                                            .resizable()
                                            .frame(width: 50, height: 50)
                                            
                                            
                                        Text("\(tables[number])")
                                            .foregroundColor(.black)
                                    }
                                })
                                .background(Color.white)
                                .clipShape(Capsule())
                                .overlay(Capsule().stroke(Color.black, lineWidth: 1))
                                .shadow(color: .white, radius: 2)
                                
                                
                            }
                        }
                        .padding()
                        
                        HStack {
                            ForEach(6..<12) { number in
                                Button(action: {
                                    selectedTable = number + 1
                                }, label: {
                                    VStack {
                                        Image(imagesName[number])
                                            .resizable()
                                            .frame(width: 50, height: 50)
                                        
                                        Text("\(tables[number])")
                                            .foregroundColor(.black)
                                    }
                                })
                                .background(Color.white)
                                .clipShape(Capsule())
                                .overlay(Capsule().stroke(Color.black, lineWidth: 1))
                                .shadow(color: .white, radius: 2)
                            }
                        }
                        .padding()
                        
                        Text("Selected tables: \(selectedTable)")
                            .font(.headline)
                            .italic()
                            .padding()
                        
                        Button(action: {
                            self.newGame()
                        }, label: {
                            Text("Play")
                                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 60)
                                .padding()
                                .foregroundColor(.black)
                                .background(Color.white)
                                .cornerRadius(40)
                        })
                        .padding(.horizontal, 20)
                        
                    }
                } else {
                    VStack {
                        Text("\(questions[currentQuestion].text)")
                            .font(.system(size: 45, weight: .bold, design: .default))
                            .multilineTextAlignment(.center)
                        
                        TextField("Answer", text: $playerAnswer)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()
                            .keyboardType(.numberPad)
                        
                        Button(action: {
                            self.checkAnswer()
                        }, label: {
                            Text("Check")
                                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 60)
                                .padding()
                                .foregroundColor(.black)
                                .background(Color.white)
                                .cornerRadius(40)
                                .rotation3DEffect(.degrees(self.buttonAngle), axis: (x: 0, y: 1, z: 0))
                                .blur(radius: self.buttonBlur)
                                .animation(.default)
                        })
                        .padding(.horizontal, 20)
                        
                        Text("Score: \(playerScore)")
                            .font(.system(size: 45, weight: .bold, design: .default))
                            .padding()
                        
                    }
                    .alert(isPresented: $showingScore) {
                        Alert(title: Text("Game over!"), message: Text("Your score was  \(playerScore), good job!"), dismissButton: .default(Text("New game")) {
                            self.endGame()
                        })
                    }
                }
            }
        }
    }
    
    func newGame() {
        
        self.isPlaying = true
        self.questions = []
        self.generateQuestions()
        self.currentQuestion = 0
        self.playerScore = 0
        self.playerAnswer = ""
        self.buttonBlur = 0
        self.buttonAngle = 0.0
    
        switch questionsToAnswer {
        case 0:
            totalQuestions = 5
        case 1:
            totalQuestions = 10
        case 2:
            if selectedTable == 1 {
                totalQuestions = questions.count
            } else {
                totalQuestions = 20
            }
        default:
            totalQuestions = questions.count
        }
    }
    
    func generateQuestions() {
        
        for i in 1...selectedTable {
            for j in 1...12 {
                let newQuestion = Question(text: "How much is \n \(i) x \(j)?", answer: i*j)
                self.questions.append(newQuestion)
            }
        }

        self.questions.shuffle()
        print(questions)
    }
    
    func checkAnswer() {
        
        if Int(playerAnswer) == questions[currentQuestion].answer {
            playerScore += 1
            buttonAngle = 360.0
        } else {
            buttonBlur = 5
        }
        
        currentQuestion += 1
        playerAnswer = ""
        
        if currentQuestion == totalQuestions {
            currentQuestion = 0
            self.showingScore = true
            return
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            buttonAngle = 0.0
            buttonBlur = 0
        }
    }
    
    func endGame() {
        self.isPlaying.toggle()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
