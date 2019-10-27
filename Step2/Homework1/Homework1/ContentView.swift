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
    @State var equalClicked = false
    
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
                    self.clean()
                }) {
                    Text("C")
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
            
            HStack{
                Spacer()
                Button(action: {
                    self.number(i: 1)
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
                    self.number(i: 2)
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
                    self.number(i: 3)
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
                    self.number(i: 4)
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
                    self.operation(o: "+")
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
                    self.operation(o: "-")
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
                    self.operation(o: "x")
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
                    self.operation(o: "/")
                })
                {
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
                    self.calc()
                    self.equalClicked = true
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
    func calc()
    {
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
    }
    func clean()
    {
        self.value1 = 0
        self.value2 = 0
        self.value = 0
        self.ops = ""
        self.equalClicked = false
    }
    func number(i:Int){
        if (self.ops==""){
            self.value1 = self.value1 * 10 + i
            self.value = self.value1
        }else{
            self.value2 = self.value2 * 10 + i
            self.value = self.value2
        }
        self.equalClicked = false
    }
    func operation(o:String){
        if self.ops == ""{
            self.ops = o
            self.value1 = self.value
        }else{
            self.calc()
            self.value1 = self.value
            self.ops = o
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
