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

// settings view
struct Settings: View {
    var title: String
    
    @State private var maxNumMultiplied = 6
    @State private var numQuestions = ["5", "10", "20", "All"]
    @State private var numQuestionChosen = "5"

    func gameStart(topNum: Int, gameNum: String) {
        
        // convert topNum to int
//        generateQuestions(topNum, gameNum)
    }
    
    func generateQuestions(topNum: Int, gameNum: String) -> [question] {
        // TODO build in logic for generating questions w/ topNum & gameNum
        let questionText = "1 x 1 = "
        let answer = 1
        let questions = [question(questionText: questionText, answer: answer)]
//        gameActive = true
        return questions
    }
    
    var body: some View {
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
//
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
}

// game view
struct Game: View {
    var text: String

    var body: some View {
        Text(text)
            .font(.largeTitle)
            .padding()
            // .foregroundColor(.white)  // remove to apply custom to instances
            .background(Color.blue)
            .clipShape(Capsule())
    }
}

// question
struct question {
    let questionText: String
    let answer: Int
}

struct ContentView: View {
    @State var gameActive = false
    @State var questions = [question]()

    
    var body: some View {
        Group {
            if gameActive {
                Game(text: "Game")
                    .foregroundColor(.white)
            } else {
                Settings(title: "Settings")
                    .foregroundColor(.white)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        ContentView()
    }
}
