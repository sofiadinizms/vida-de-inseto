//
//  Level4View.swift
//  VidaDeInseto
//
//  Created by aaav on 20/10/22.
//

import SwiftUI
import AVFoundation
import MediaPlayer

struct ContentView: View {
    
    var screenSize = UIScreen.main.bounds
    @State var offset : CGFloat = 0
    let numStages : Int = 4
    @State var stage : Int = 1
    @State private var winPlayer: AVAudioPlayer!

    
    @State private var level = 1
    
    var body: some View {
        switch level{
        case 1:
            LevelOneView(nextLevel:$level)
        case 2:
            CutSceneView(nextLevel: $level)
        case 3:
            LevelTwoView(nextLevel: $level)
        case 4:
            CutSceneView(nextLevel: $level)
        case 5:
            LevelThreeView(nextLevel: $level)
        case 6:
            CutSceneView(nextLevel: $level)
        case 7:
            LevelFourView(nextLevel: $level)
        case 8:
            CutSceneView(nextLevel: $level)
        case 9:
            LevelFiveView(nextLevel: $level)
        case 10:
            CutSceneView(nextLevel: $level)
        case 11:
            LevelSixView(nextLevel: $level)
        default:
            LevelOneView(nextLevel: $level)
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
