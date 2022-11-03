//
//  CutSceneView.swift
//  VidaDeInseto
//
//  Created by aaav on 02/11/22.
//

import AVFoundation
import MediaPlayer
import SwiftUI

struct CutSceneView: View {
    
    @State var txai : String = ""
    @State var offsetY : CGFloat = 0
    @State private var climbPlayer: AVAudioPlayer!
    let screenSize = UIScreen.main.bounds
    @State var repeats = true
    @Binding var nextLevel: Int
    
    
    var body: some View {
        ZStack{
            VStack{
                
                Image("background_cutscene2")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                    .aspectRatio(contentMode: .fill)
                    .offset(y: -100)
                    .offset(y: offsetY)
                    .animation(.spring(), value: offsetY)
                
            }
            
            Image(txai)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: screenSize.width/3, alignment: .center)
                .onAppear(perform: timerTxai)
                
        }
    }
    
    func timerTxai(){
    
        var index = 1
        var turns = 0
        
        let timer = Timer.scheduledTimer(withTimeInterval: 0.15, repeats: true) { (Timer) in
            
            txai = "txai_subindo\(index)"
            
            if repeats{
                index += 1
            }
            
            if (index == 3){
                offsetY += 35
            }
            
            if (index == 5){
                climbPlayer = playSounds("sfx_movement_ladder1a.wav", 1)
                climbPlayer.play()
            }
            
            if (index > 8){
                index = 1
                turns += 1
            }
            
            if (turns == 4){
                turns += 1
                nextLevel += 1
                repeats = false
            }
            
        }
    }
}



struct CutSceneView_Previews: PreviewProvider {
    static var previews: some View {
        CutSceneView(nextLevel: .constant(2))
    }
}
