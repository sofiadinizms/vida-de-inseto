//
//  FoodImageUIView.swift
//  VidaDeInseto
//
//  Created by sofiadinizms on 24/10/22.
//

import SwiftUI

struct FoodImageUIView: View {
    
    @Binding var shakeAmount: Int
    
    var xPositions = [-180, -130, -120, -70, -80,
                       -20, 0, 30, 60, 90, 90, 150, 140, -30]
    var yPositions = [-180, -160, -210, -190, -140,
                       -180, -130, -190, -260, -210, -150, -250, -180, -240]
    
    var body: some View {
        VStack{
            ZStack{
                ForEach(0..<14){i in
                    Circle()
                        .frame(width: 15, height: 15, alignment: .center)
                        .overlay(Image("apple"))
                        .foregroundColor(.clear)
                        .offset(x: shakeAmount == 1 ? CGFloat(xPositions[i]) : 0, y: shakeAmount == 1 ? CGFloat(yPositions[i]) : 0)
                        .opacity(shakeAmount > 0 ? 1 : 0)
                        .animation(.easeInOut.speed(0.2), value: shakeAmount)
                }
            }
            
        }
    }
}

struct FoodImageUIView_Previews: PreviewProvider {
    static var previews: some View {
        FoodImageUIView(shakeAmount: .constant(1))
    }
}
