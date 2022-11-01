//
//  Level4View.swift
//  VidaDeInseto
//
//  Created by aaav on 20/10/22.
//

import SwiftUI

struct ContentView: View {
    
    var screenSize = UIScreen.main.bounds
    @State var offset : CGFloat = 0
    let numStages : Int = 4
    @State var stage : Int = 1
    
    var body: some View {
        ZStack{
            LazyVStack (spacing: 0){
                LevelSixView()
                Level4View()
                LevelTwoView()
                LevelOneView()


            }
                .offset(y: -screenSize.height * (CGFloat(numStages)-1)/2.0)
                .offset(y: offset)
                .animation(.easeOut(duration: 6), value: offset)
            
            VStack(){
                Circle()
                    .opacity(0)
                
                Button("Caminhar"){
                    if (stage < numStages){
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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
