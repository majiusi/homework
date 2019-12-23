//
//  ContentView.swift
//  QRScanner
//
//  Created by 马九思 on 2019/12/21.
//  Copyright © 2019 马九思. All rights reserved.
//


import AVFoundation
import SwiftUI


struct ContentView: View {
    @State static var result = ""
    @State var showView = false{
        didSet{
            print("prepare to navigation")
            var nib=Camera(coder: .init())
            presentViewController(nib, animated:true, completion: nil)
        }
    }
    
    
    
    var body: some View {
        NavigationView {
            VStack{
                Spacer()
                Button(action: {
                    self.showView = true
                }){
                    Image(systemName: "camera").resizable().frame(width: CGFloat(100), height: CGFloat(85), alignment: .center)
                }
                Spacer()
                Text("Result is:")
                HStack{
                    Spacer()
                    TextField("Empty!", text: ContentView.$result).border(Color.black)
                        .frame(width: 200, height: .none, alignment: .center).multilineTextAlignment(.center)
                    Spacer()
                }
                Button(action: {print("Show Button Clicked!")}){
                    Text("Show me the web page")
                }
                
                Spacer()
            }
            .navigationBarTitle("QRScanner", displayMode: .inline)
        }
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
