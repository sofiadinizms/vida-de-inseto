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
    @State var rounds : Int = 0
    @State var prev : CGFloat = 0
    @State var won : Bool = false
    
    private func change(location: CGPoint) {
            let vector = CGVector(dx: location.x, dy: location.y)
            let angle = atan2(vector.dy - (radius/2 + 10), vector.dx - (radius/2 + 10)) + .pi/2.0
            let fixedAngle = angle < 0.0 ? angle + 2.0 * .pi : angle
            angleValue = fixedAngle * 180 / .pi
            }
    
    var body: some View {

        ZStack{
            Circle()
                .fill(Color.black)
                .opacity(0.2)
                .frame(width: radius * 2, height: radius * 2)
            
            Circle()
                .fill(Color.red)
                .frame(width: radius, height: radius)
                .opacity(0.5)
                .offset(y: -radius/2)
                .rotationEffect(Angle.degrees(Double(angleValue)))
                .gesture(
                    DragGesture()
                        .onChanged{ value in
                            change(location: value.location)
                            if ((prev - angleValue) > 300){
                                rounds += 1
                                if (rounds == 5){
                                    won.toggle()
                                    print(rounds)
                                    print(won)
                                }
                            }
                            prev = angleValue
                        }
                        .onEnded {_ in
                            angleValue = 0.0
                            rounds = 0
                        }
                )
            
            Text(won ? "Ganhou" : "")
            
        }
        
    }
}

struct LevelSixView_Previews: PreviewProvider {
    static var previews: some View {
        LevelSixView()
    }
}
