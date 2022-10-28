//
//  LevelThreeView.swift
//  VidaDeInseto
//
//  Created by sofiadinizms on 24/10/22.
//

import SwiftUI

func Check(){
    print(UIScreen.main.brightness)
}

struct LevelThreeView: View {
    @State var brightness = UIScreen.main.brightness
    
    var body: some View {
        if brightness == 0{
            Image(systemName: "star.fill")
        } else {
            Text("Brilho não tá no zero")
        }
    }
}

struct LevelThreeView_Previews: PreviewProvider {
    static var previews: some View {
        LevelThreeView()
    }
}
