//
//  ContentView.swift
//  Homework1
//
//  Created by Margis on 2019/10/19.
//  Copyright © 2019 Margis. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var value1 = 0
    @State var value2 = 0
    @State var value = 0
    @State var ops = ""
    
    var body: some View {
        VStack{
            Text("Homework1 - Calc")
            Spacer()
            // 计算结果
            HStack{
                Spacer()
                Text("\(value)")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color.gray)
                    .multilineTextAlignment(.trailing)
                Spacer()
            }
            .padding(.top, 10)
            Spacer()
            
            // 数字区
            HStack{
                Spacer()
                Button(action: {
                    if (self.ops==""){
                        self.value1 = self.value1 * 10 + 1
                        self.value = self.value1
                    }else{
                        self.value2 = self.value2 * 10 + 1
                        self.value = self.value2
                    }
                }) {
                    Text("1")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color.black)
                        .multilineTextAlignment(.trailing)
                }
                .frame(width: 80, height: 80, alignment: .center)
                .background(Color.orange)
                .cornerRadius(10)
                Button(action: {
                    if (self.ops==""){
                        self.value1 = self.value1 * 10 + 2
                        self.value = self.value1
                    }else{
                        self.value2 = self.value2 * 10 + 2
                        self.value = self.value2
                    }
                }) {
                    Text("2")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color.black)
                        .multilineTextAlignment(.trailing)
                }
                .frame(width: 80, height: 80, alignment: .center)
                .background(Color.orange)
                .cornerRadius(10)
                
                Button(action: {
                    if (self.ops==""){
                        self.value1 = self.value1 * 10 + 3
                        self.value = self.value1
                    }else{
                        self.value2 = self.value2 * 10 + 3
                        self.value = self.value2
                    }
                }) {
                    Text("3")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color.black)
                        .multilineTextAlignment(.trailing)
                }
                .frame(width: 80, height: 80, alignment: .center)
                .background(Color.orange)
                .cornerRadius(10)
                
                Button(action: {
                    if (self.ops==""){
                        self.value1 = self.value1 * 10 + 4
                        self.value = self.value1
                    }else{
                        self.value2 = self.value2 * 10 + 4
                        self.value = self.value2
                    }
                }) {
                    Text("4")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color.black)
                        .multilineTextAlignment(.trailing)
                }
                .frame(width: 80, height: 80, alignment: .center)
                .background(Color.orange)
                .cornerRadius(10)
                
                Spacer()
            }.padding(.top,10)
            HStack{
                Spacer()
                Button(action: {
                    self.ops = "+"
                }) {
                    Text("➕")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color.black)
                        .multilineTextAlignment(.trailing)
                }
                .frame(width: 80, height: 80, alignment: .center)
                .background(Color.orange)
                .cornerRadius(10)
                Button(action: {
                    self.ops = "-"
                }) {
                    Text("➖")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color.black)
                        .multilineTextAlignment(.trailing)
                }
                .frame(width: 80, height: 80, alignment: .center)
                .background(Color.orange)
                .cornerRadius(10)
                
                Button(action: {
                    self.ops = "x"
                }) {
                    Text("✖️")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color.black)
                        .multilineTextAlignment(.trailing)
                }
                .frame(width: 80, height: 80, alignment: .center)
                .background(Color.orange)
                .cornerRadius(10)
                
                Button(action: {
                    self.ops = "/"
                }) {
                    Text("➗")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color.black)
                        .multilineTextAlignment(.trailing)
                }
                .frame(width: 80, height: 80, alignment: .center)
                .background(Color.orange)
                .cornerRadius(10)
                
                Spacer()
            }.padding(.top,10)
            
            HStack{
                Spacer()
                Button(action: {
                    switch self.ops {
                    case "+":
                        self.value = self.value1 + self.value2
                    case "-":
                        self.value = self.value1 - self.value2
                    case "x":
                        self.value = self.value1 * self.value2
                    case "/":
                        self.value = self.value1 / self.value2
                    default: break
                    }
                    self.value1 = 0
                    self.value2 = 0
                    self.ops = ""
                }) {
                    Text("=")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color.black)
                        .multilineTextAlignment(.trailing)
                }
                .frame(width: 340, height: 80, alignment: .center)
                .background(Color.orange)
                .cornerRadius(10)
                Spacer()
            }.padding(.top,10)
            
            Spacer()
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
