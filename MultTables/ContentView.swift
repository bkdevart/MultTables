//
//  ContentView.swift
//  MultTables
//
//  Created by Brandon Knox on 3/14/21.
//

import SwiftUI



struct ContentView: View {
    
    // settings view
    struct Settings: View {
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
            Settings(text: "Settings")
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
