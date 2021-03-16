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

struct ContentView: View {
    
    
    
    // settings view
    struct Settings: View {
        var title: String
        
        @State private var maxNumMultiplied = 6
        @State private var numQuestions = ["5", "10", "20", "All"]

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
                        // start game
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
    
    var body: some View {
        Group {
            Settings(title: "Settings")
                .foregroundColor(.white)
            Game(text: "Game")
                .foregroundColor(.white)
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    @State var gameActive = true
    
    
    
    
    
    static var previews: some View {
        ContentView()
    }
}
