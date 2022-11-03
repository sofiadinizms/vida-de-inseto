//
//  LevelOneView.swift
//  VidaDeInseto
//
//  Created by sofiadinizms on 24/10/22.
//

import SwiftUI

// The notification we'll send when a shake gesture happens.
extension UIDevice {
    static let deviceDidShakeNotification = Notification.Name(rawValue: "deviceDidShakeNotification")
}

//  Override the default behavior of shake gestures to send our notification instead.
extension UIWindow {
    open override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            NotificationCenter.default.post(name: UIDevice.deviceDidShakeNotification, object: nil)
        }
    }
}

// A view modifier that detects shaking and calls a function of our choosing.
struct DeviceShakeViewModifier: ViewModifier {
    let action: () -> Void
    
    func body(content: Content) -> some View {
        content
            .onAppear()
            .onReceive(NotificationCenter.default.publisher(for: UIDevice.deviceDidShakeNotification)) { _ in
                action()
            }
    }
}

// A View extension to make the modifier easier to use.
extension View {
    func onShake(perform action: @escaping () -> Void) -> some View {
        self.modifier(DeviceShakeViewModifier(action: action))
    }
}

struct LevelOneView: View {
    
    @State private var imageShow = 0
    @State var isShaken = false
    @State private var alertIsPresented = false
    @Binding var nextLevel: Int
    let screenSize = UIScreen.main.bounds
//    let victoryPlayer = playSounds("sfx_sounds_powerup16.wav", 1)
//    let hungerPlayer = playSounds("sfx_deathscream_android7", 1)

    
    var body: some View {
        
        ZStack{
            Image("sky")
                .resizable()
                .edgesIgnoringSafeArea(.all)
                .aspectRatio(contentMode: .fill)
                .offset(x:20)
            
            Image("tronco1")
                .resizable()
                .edgesIgnoringSafeArea(.all)
                .aspectRatio(contentMode: .fit)
                .offset(x:-15)
            
            Image("plant")
                .resizable()
                .edgesIgnoringSafeArea(.all)
                .aspectRatio(contentMode: .fit)
                .offset(x:-15)
            
            VStack{
                ZStack{
                    
                    FoodImageUIView(shakeAmount: $imageShow)
                    
                    Image(imageShow == 2 ? "happy-mushroom" : "dizzy-mushroom")
                        .resizable()
                        .frame(width: screenSize.width * 0.5, height: screenSize.width * 0.5)

                        .onShake {
                            imageShow += 1
                            
                            if (imageShow == 2){
//                                victoryPlayer?.play()
                                DispatchQueue.main.asyncAfter(deadline: .now() + 3.5){
                                    nextLevel += 1
                                    
                                }
                            }
                            
                            isShaken = true
                            print("Device shaken!")
                        }
                    if imageShow == 0 {
                        Button(action: {
                            self.alertIsPresented = true
                        }, label: {
                            Image("balloon1")
                        })
                        .frame(width: 80, height: 80, alignment: .center)
                        .padding()
                        .foregroundColor(.clear)
                        .offset(x: 100, y: -160)
                        .alert(isPresented: $alertIsPresented, content: {
                            Alert(title: Text("Que fome!"), message: Text("Essa frutinhas parecem apetitosas, pena que o Txai não consegue colhê-las sozinho. Você poderia dar uma mãozinha (duas, na verdade…) para que as frutinhas caiam da árvore?"), dismissButton: .default(Text("Vamos lá!")))
                        })
                        
                        
                        
                        
                    }
                }
            }
            
        }
    }
}

struct LevelOneView_Previews: PreviewProvider {
    static var previews: some View {
        LevelOneView(nextLevel: .constant(1))
    }
}
