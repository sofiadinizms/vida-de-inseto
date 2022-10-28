//
//  LevelTwoView.swift
//  VidaDeInseto
//
//  Created by mcor on 26/10/22.
//

import SwiftUI

struct LevelTwoView: View {
    var body: some View {
        PinchGestureView()
    }
}

struct PinchGestureView: View {
    
    private let minZoom: CGFloat = 1.00
    private let maxZoom: CGFloat = 2.00
    
    
    @GestureState private var magnificationLevel: CGFloat = 1
    @State private var zoomLevel: CGFloat = 1
    
    var body: some View {
        Image("mushroom")
            .scaleEffect(setZoom(magnification: magnificationLevel))
            .gesture(MagnificationGesture().updating($magnificationLevel, body: { value, state, _ in
                state = value
            }) .onEnded({ value in
                withAnimation {self.zoomLevel = minZoom
                }
                
                
            }))
    }
    
    func setZoom(magnification: CGFloat) -> CGFloat {
        return max(min(self.zoomLevel * magnification, self.maxZoom), self.minZoom)
    }
}


struct LevelTwoView_Previews: PreviewProvider {
    static var previews: some View {
        LevelTwoView()
    }
}
