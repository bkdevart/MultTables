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


// question
struct Question {
    let questionText: String
    let answer: Int
}

struct GamePlay: View {
    var body: some View {
        Text("Game")
            .font(.largeTitle)
            .padding()
            // .foregroundColor(.white)  // remove to apply custom to instances
            .background(Color.blue)
            .clipShape(Capsule())
    }
}

struct Settings: View {
    @Binding var gameActive: Bool
    @Binding var maxNumMultiplied: Int
    @Binding var numQuestions: [String]
    @Binding var numQuestionChosen: String
    @Binding var questions: [Question]
    
    var body: some View {
        // settings view
        NavigationView {
            VStack {
                Stepper(value: $maxNumMultiplied) {
                    Text("Numbers go from 1 to: \(maxNumMultiplied)")
                        .padding()
                        .background(Color.blue)
                        .clipShape(Capsule())
                        .font(.headline)
                }
                Text("Number of games")
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
                Button("Start", action: {
                    gameStart(topNum: maxNumMultiplied, gameNum: numQuestionChosen)
                })
                .padding()
                .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.blue/*@END_MENU_TOKEN@*/)
                .foregroundColor(.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .font(.headline)
            }
            .navigationBarTitle("Settings")
            .padding()
        }
    }
    
    func gameStart(topNum: Int, gameNum: String) {
        
        // convert topNum to int
        questions = generateQuestions(topNum: topNum, gameNum: gameNum)
    }
    
    func generateQuestions(topNum: Int, gameNum: String) -> [Question] {
        // TODO build in logic for generating questions w/ topNum & gameNum
        let questionText = "1 x 1 = "
        let answer = 1
        let questions = [Question(questionText: questionText, answer: answer)]
        gameActive = true
        return questions
    }
}


struct ContentView: View {
    @State var gameActive = false
    @State var questions = [Question]()
    @State var maxNumMultiplied = 6
    @State var numQuestions = ["5", "10", "20", "All"]
    @State var numQuestionChosen = "5"

    var gameState: some View {
        Group {
            VStack {
                if gameActive {
                    GamePlay()
                } else {
                    Settings(gameActive: gameActive, maxNumMultiplied: maxNumMultiplied, numQuestions: numQuestions, numQuestionChosen: numQuestionChosen, questions: questions)
                }
            }
        }
    }
    
    var body: some View {
        gameState
    }
}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        ContentView()
    }
}
