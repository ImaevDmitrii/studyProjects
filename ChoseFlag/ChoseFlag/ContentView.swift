//
//  ContentView.swift
//  ChoseFlag
//
//  Created by Дмитрий Имаев on 04.01.2023.
//

import SwiftUI

struct ContentView: View {
    
    @State private var countries = ["UK","USA","Russia","Brazil", "Bangladesh","Argentina","Canada","Germany","Greece","Sweden"].shuffled()
    
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var score = 0
    
    @State private var showingScore = false
    
    @State private var  scoreTitle = ""
    
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [.white, .gray]), startPoint: .top, endPoint: .trailing)
            VStack(spacing: 35) {
                VStack{
                    Text("Chose a flag: ")
                        .font(.title)
                    Text(countries[correctAnswer])
                        .font(.largeTitle)
                }
                ForEach(0..<3) { number in
                    Button(action: {
                        self.flagTapped(number)
                        self.showingScore = true
                    }) {
                        Image(self.countries[number])
                            .renderingMode(.original)
                            .frame(width: 250,height: 130)
                            .clipShape(Capsule())
                            .overlay(Capsule()
                                .stroke(Color .black, lineWidth: 2))
                            .shadow(radius: 3)
                        
                    }
                    
                }
                Text("Total score: \(score)")
                    .font(.title3)
                    .fontWeight(.black)
            }
        } .ignoresSafeArea(.all)
            .alert(isPresented: $showingScore) {
                Alert(title: Text(scoreTitle), message: Text("Total score: \(score)"), dismissButton: .default(Text("Next")){
                    self.askQuestion()
                })
            }
        
    }
    
    func askQuestion(){
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer{
            scoreTitle = "Correct"
            score += 1
        } else {
            scoreTitle = "Wrong, its a flag \(countries[number])"
            score -= 1
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
