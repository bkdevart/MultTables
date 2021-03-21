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
    var questions: [Question]
    @State var userAnswer = ""
    
    init(questions: [Question]) {
        self.questions = questions
    }
    
    func checkAnswer(answer: Int) {
        // check if userAnswer is correct
        if Int(userAnswer) == answer {
            print("Right!")
        } else {
            print("Wrong!")
        }
    }
    
    var body: some View {
        Text("Game")
            .font(.largeTitle)
            .padding()
            .foregroundColor(.white)
            .background(Color.blue)
            .clipShape(Capsule())
        List {
            ForEach(0 ..< questions.count) { question in
                Text(questions[question].questionText)
                TextField("Enter your answer", text: $userAnswer)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                    .padding()
                Button("Submit Answer", action: {
                     checkAnswer(answer: questions[question].answer)
                })
            }
        }
    }
}

struct Settings: View {
    var gameActive: Bool
    @State var maxNumMultiplied = 6
    var numQuestions: [String]
    var numQuestionChosen: String
    
    init(gameActive: Bool, numQuestions: [String], numQuestionChosen: String) {
        self.gameActive = gameActive
        self.numQuestions = numQuestions
        self.numQuestionChosen = numQuestionChosen
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
    @State var gameActive = false
    @State var numQuestions = ["5", "10", "20", "All"]
    @State var numQuestionChosen = "5"
    @State var maxNumMultiplied = 6
    
    func generateQuestions() -> [Question] {
        var questions = [Question]()
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
        questions = Array(questions[0 ..< 5])
        
        return questions
    }
    
    var body: some View {

        Group {
            VStack {
                if gameActive {
                    GamePlay(questions: generateQuestions())
                } else {
                    Settings(gameActive: gameActive, numQuestions: numQuestions, numQuestionChosen: numQuestionChosen)
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
