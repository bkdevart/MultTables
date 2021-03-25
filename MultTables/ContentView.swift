//
//  ContentView.swift
//  MultTables
//
//  Created by Brandon Knox on 3/14/21.
//

import SwiftUI

// custom view modifier
struct SettingButton: ViewModifier {
    func body(content: Content) -> some View {
            content
                .padding()
                .foregroundColor(.white)
                .background(Color.blue)
                .clipShape(Circle())
                .font(.headline)
    }
}

// creating an extension for the view modifier makes it easier to use
extension View {
    func settingButtonStyle() -> some View {
        self.modifier(SettingButton())
    }
}

struct Question {
    let questionText: String
    let answer: Int
}

struct GamePlay: View {
    @State private var userAnswer = ""
    @State private var questionNum = 0
    var questions = [Question]()
    var maxNumMultiplied: Int
    var numQuestionChosen: String
    
    init(maxNumMultiplied: Int, numQuestionChosen: String) {
        self.maxNumMultiplied = maxNumMultiplied
        self.numQuestionChosen = numQuestionChosen
        generateQuestions(maxNumMultiplied: self.maxNumMultiplied)
    }
    
    mutating func generateQuestions(maxNumMultiplied: Int) {
        // TODO build in logic for generating questions w/ numQuestionChosen
        for firstValue in 1 ... maxNumMultiplied {
            for secondValue in 1 ... maxNumMultiplied {
                let questionText = "\(String(firstValue)) x \(String(secondValue))"
                let answer = firstValue * secondValue
                let question = Question(questionText: questionText, answer: answer)
                questions.append(question)
            }
        }
        questions = questions.shuffled()
        var totalQuestions = Int(numQuestionChosen) ?? questions.count
        if totalQuestions > questions.count {
            totalQuestions = questions.count
        }
        questions = Array(self.questions[0 ..< totalQuestions])  // use settings #
    }
    
    func checkAnswer(answer: Int) {
        // check if userAnswer is correct
        if Int(userAnswer) == answer {
            print("Right!")
        } else {
            print("Wrong!")
        }
    }
    
    func pickQuestion() -> Question {
        if questionNum  < questions.count {
            let nextQuestion = questions[questionNum]
            return nextQuestion
        } else {
            let endGame = Question(questionText: "Game Over", answer: 0)
            return endGame
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Text(pickQuestion().questionText)
                    .bold()
                    .fontWeight(.heavy)
                    .font(.headline)
                
                TextField("Enter your answer", text: $userAnswer)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                    .padding()
                
                Button("Submit Answer", action: {
                    checkAnswer(answer: questions[questionNum].answer)
                    questionNum += 1
                })
                    .font(.largeTitle)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .clipShape(Capsule())
            }
            .navigationBarTitle("Game")
            .padding()
        }
    }
}

struct Settings: View {
    @Binding var maxNumMultiplied: Int
    @Binding var numQuestionChosen: String
    @State var numQuestions = ["5", "10", "20", "All"]
    
    var body: some View {
        NavigationView {
            VStack {
                Stepper(value: $maxNumMultiplied) {
                    Text("Numbers go from 1 to: \(maxNumMultiplied)")
                        .padding()
                        .background(Color.blue)
                        .clipShape(Capsule())
                        .font(.headline)
                        .foregroundColor(.white)
                }
                Text("Number of questions")
                    .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                    .fontWeight(.bold)
                HStack {
                    ForEach(0..<4) { number in
                        Button(action: {
                            print("Tapped \(numQuestions[number])")
                        }) {
                            Text(numQuestions[number])
                                .settingButtonStyle()
                        }
                    }
                }
                Spacer()
            }
            .navigationBarTitle("Settings")
            .padding()
        }
    }
}


struct ContentView: View {
    @State var maxNumMultiplied = 6
    @State var numQuestionChosen = "5"
    @State var gameActive = false
    
    var body: some View {

        Group {
            VStack {
                if gameActive {
                    GamePlay(maxNumMultiplied: maxNumMultiplied, numQuestionChosen: numQuestionChosen)
                } else {
                    Settings(maxNumMultiplied: $maxNumMultiplied, numQuestionChosen: $numQuestionChosen)
                }
                Button(gameActive ? "Settings" : "Start", action: {
                    gameActive.toggle()
                })
                .padding()
                .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.blue/*@END_MENU_TOKEN@*/)
                .foregroundColor(.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .font(.headline)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        ContentView()
    }
}
