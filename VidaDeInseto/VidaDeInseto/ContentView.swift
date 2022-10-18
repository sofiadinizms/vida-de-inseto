//
//  ContentView.swift
//  VidaDeInseto
//
//  Created by aaav on 18/10/22.
//

import SwiftUI

struct ContentView: View {
    @State var stages : [Image] = [
        Image("background1"),
        Image("background2"),
        Image("background3"),
        Image("background4"),
        Image("background5"),
        Image("background6"),
    ]
    
    var screenSize = UIScreen.main.bounds
    @State var offset : CGFloat = 0
    @State var stage : Int = 1

    var body: some View {
        ZStack(){
            LazyVStack(spacing:0){
                ForEach(0..<6){ i in
                    stages[i]
                        .resizable()
                        .edgesIgnoringSafeArea(.all)
                        .aspectRatio(contentMode: .fill)
                }
                .offset(y: -screenSize.height * CGFloat(stages.count - 1)/2.0)
                .offset(y: offset)
                .animation(.easeOut(duration: 6), value: offset)
                
            }
            Button("Caminhar"){
                if (stage < 6){
                    offset += screenSize.height
                    stage += 1
                } else {
                    print("You did it!")
                }
            }
            .background(.black)
            
        }
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
