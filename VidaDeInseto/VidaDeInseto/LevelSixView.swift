//
//  LevelSixView.swift
//  VidaDeInseto
//
//  Created by aaav on 26/10/22.
//

import SwiftUI

struct LevelSixView: View {
    
    @State var angleValue: CGFloat = 0.0
    let radius : CGFloat = 100

    private func change(location: CGPoint) {
            let vector = CGVector(dx: location.x, dy: location.y)
            let angle = atan2(vector.dy - (radius/2 + 10), vector.dx - (radius/2 + 10)) + .pi/2.0
            let fixedAngle = angle < 0.0 ? angle + 2.0 * .pi : angle

            angleValue = fixedAngle * 180 / .pi
            }
    
    var body: some View {

        ZStack{
            Circle()
                .fill(Color.green)
                .frame(width: radius * 2, height: radius * 2)
            
            Circle()
                .fill(Color.red)
                .frame(width: radius/2, height: radius/2)
                .padding(radius/2 - radius/4)
                .offset(y: -radius)
                .rotationEffect(Angle.degrees(Double(angleValue)))
                .gesture(
                    DragGesture()
                        .onChanged{ value in
                            change(location: value.location)
                        }
                        .onEnded {_ in
                            angleValue = 0.0
                        }
                )
            
            
        }
        
    }
}

struct LevelSixView_Previews: PreviewProvider {
    static var previews: some View {
        LevelSixView()
    }
}
