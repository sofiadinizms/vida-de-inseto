//
//  LevelThreeView.swift
//  VidaDeInseto
//
//  Created by sofiadinizms on 01/11/22.
//

import SwiftUI

struct LevelThreeView: View {
    @State var brightness = UIScreen.main.brightness
    @State var night = false
    @Environment(\.scenePhase) var scenePhase
    @Binding var nextLevel: Int
    
    var body: some View {
        VStack{
            if night{
                Image("moon")
            } else {
                Image("sun")
            }
            Image("sad-mushroom")
        }.onChange(of: scenePhase) { newPhase in
            if (newPhase == .active) {
                print("Active -- \(UIScreen.main.brightness)")
                if UIScreen.main.brightness == CGFloat(0){
                    print("ganhou!")
                    night = true
                    nextLevel += 1
                }
                
            } else if newPhase == .inactive{
                print("Inactive")
                
            } else if (newPhase == .background) {
                print("Background")
            }
            
        }
    }
}


struct LevelThreeView_Previews: PreviewProvider {
    static var previews: some View {
        LevelThreeView(nextLevel: .constant(1))
    }
}
