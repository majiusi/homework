//
//  ContentView.swift
//  Lesson1
//
//  Created by Margis on 2019/10/19.
//  Copyright © 2019 Margis. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var sliderValue = 50.0
    @State var alert = false
    @State var target = Int.random(in: 1...100)
    
    var body: some View {
        VStack {
            VStack{
                //target row
                Spacer()
                Text("The target is \(target)")
                    .font(.largeTitle)
                    .foregroundColor(.green)
                //slider row
                Spacer()
                HStack{
                    Text("1")
                    Slider(value: self.$sliderValue, in: 1...100)
                    Text("100")
                }
                //button row
                Spacer()
                Button(action:{self.alert = true}){
                    Text("Hit me!")
                }
                .alert(isPresented: self.$alert) { () -> Alert in
                    let roundedValue = Int(self.sliderValue.rounded())
                    return Alert(title: Text("Hello?"), message: Text("Current Value is \(roundedValue)"), dismissButton: .default(Text("OK")))
                }
                //score row
                Spacer()
                HStack{
                    Button(action: {}){
                        Text("Restart")
                    }
                    Spacer()
                    Text("Score:")
                    Text("0")
                    Spacer()
                    Text("Round:")
                    Text("1")
                    Spacer()
                    Button(action: {}){
                        Text("Info")
                    }
                }
            }
        }
        .padding(.bottom, 20)
    }
    
    func someFunction() -> Int {
        let value:Int
        if target < 50 {
            value = 1
        } else if target == 50{
            value = 50
        }else{
            value = 100
        }
        return value
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewLayout(.fixed(width: 896, height: 414))
    }
}
