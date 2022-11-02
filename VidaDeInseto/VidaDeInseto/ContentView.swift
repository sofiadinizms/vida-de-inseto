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
    
    @State private var level = 1
    
    var body: some View {
        switch level{
        case 1:
            LevelOneView(nextLevel:$level)
        case 2:
            LevelTwoView(nextLevel: $level)
        case 3:
            LevelThreeView(nextLevel: $level)
        case 4:
            LevelFourView(nextLevel: $level)
        case 5:
            LevelFiveView(nextLevel: $level)
        case 6:
            LevelSixView(nextLevel: $level)
        default:
            LevelOneView(nextLevel: $level)
        }
        
//        ZStack{
//            LazyVStack (spacing: 0){
//                LevelSixView()
//                LevelFiveView()
//                LevelFourView()
//                LevelThreeView()
//                LevelTwoView()
////                LevelOneView()
//
//
//            }
//                .offset(y: -screenSize.height * (CGFloat(numStages)-1)/2.0)
//                .offset(y: offset)
//                .animation(.easeOut(duration: 6), value: offset)
//
//            VStack(){
//                Circle()
//                    .opacity(0)
//
//                Button("Caminhar"){
//                    if (stage < numStages){
//                        offset += screenSize.height
//                        stage += 1
//                    } else {
//                        print("You did it!")
//                    }
//                }
//                .background(.black)
//            }
//        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
