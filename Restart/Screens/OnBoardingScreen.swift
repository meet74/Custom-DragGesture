//
//  OnBoardingScreen.swift
//  Restart
//
//  Created by Meet Patel on 2023-11-06.
//

import SwiftUI

struct OnBoardingScreen: View {
    
    @AppStorage("onboarding") var onBoarding: Bool = true
    
    @State var buttonOffSet:CGFloat = 0
    @State var buttonWidth:Double = UIScreen.main.bounds.width - 80
    
    @State var isAnimating: Bool = false
    
    @State var imageOffSet:CGSize = .zero
    @State var indicatingOpacity:CGFloat  = 1
    
    @State var headerText:String = "Share"
    
    let hapticFeedback = UINotificationFeedbackGenerator()
    
    var body: some View {
        ZStack{
            Color("ColorBlue").ignoresSafeArea(.all,edges: .all)
            Spacer()
            VStack(spacing:10){
                
                Text(headerText)
                    .foregroundColor(.white)
                    .fontWeight(.heavy)
                    .font(.system(size: 54))
                    .opacity(isAnimating ? 1 : 0)
                    .offset(y: isAnimating ? 0 : -40)
                    .animation(.easeOut(duration: 1), value: isAnimating)
                    
                Text("""
                     It's not how much give but
                     how much love we put into giving
                     """)
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
                .font(.title3)
                .fontWeight(.light)
                
                ZStack{
                    CircleGroupView(ShapeColor: Color.white, ShapeOpacity: 0.2)
                        .offset(x:imageOffSet.width * -1)
                        .blur(radius: abs(imageOffSet.width/5))
                        .animation(.easeOut(duration: 1), value: imageOffSet)
                    Image("character-1").resizable().scaledToFit()
                        .offset(x:imageOffSet.width*1.2,y:0)
                        .rotationEffect(.degrees(Double(imageOffSet.width/20)))
                        .animation(.easeOut(duration: 1), value: imageOffSet)
                        .gesture(
                            DragGesture().onChanged({gesture in
                                if (abs(imageOffSet.width)<=150){
                                    imageOffSet = gesture.translation
                                    withAnimation(.easeOut(duration: 0.25)){
                                        indicatingOpacity = 0
                                        headerText = "Give"
                                    }
                                }
                            }).onEnded({_ in
                                imageOffSet = .zero
                                withAnimation(.easeIn(duration: 0.25)){
                                    indicatingOpacity = 1
                                    headerText = "Share"
                                }
                            })
                        )
                }//:ZStack
                .overlay(
                Image(systemName: "arrow.left.and.right.circle")
                    .font(.system(size: 44,weight: .ultraLight))
                    .foregroundColor(.white)
                    .offset(y:20)
                    .opacity(isAnimating ? 1 :0)
                    .opacity(indicatingOpacity),
                
                alignment: .bottom
                    
                )
                
                ZStack{
                    Capsule().fill(Color.white.opacity(0.2))
                    Capsule().fill(Color.white.opacity(0.2))
                        .padding(8)
                    
                    Text("Get Started")
                        .font(.system(.title3, design: .rounded))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .offset(x:20)
                    HStack{
                        Capsule().fill(Color("ColorRed")).frame(width: buttonOffSet+80,alignment: .center)
                        Spacer()
                    }
                    
                    HStack{
                        ZStack{
                            Capsule().fill(Color("ColorRed"))
                            Capsule().fill(Color(.black).opacity(0.15)).padding(8)
                            
                            Image(systemName: "chevron.right.2")
                                .font(.system(size: 24,weight: .bold))
                        }.frame(width: 80,height: 80,alignment: .center).foregroundColor(.white)
                            .offset(x:buttonOffSet)
                            .gesture(
                                DragGesture().onChanged({ gesture in
                                    if gesture.translation.width > 0 && buttonOffSet < buttonWidth - 80{
                                        buttonOffSet = gesture.translation.width
                                    }
                                }).onEnded({_ in
                                    withAnimation(Animation.easeOut(duration: 0.5)){
                                        if(buttonOffSet <= buttonWidth/2){
                                            hapticFeedback.notificationOccurred(.warning)
                                            buttonOffSet = 0
                                        }else{
                                            hapticFeedback.notificationOccurred(.success)
                                            playSound(sound: "chimeup", type: "mp3")
                                            onBoarding = false
                                            buttonOffSet = buttonWidth-80
                                        }
                                    }
                                })
                            )
                        
                        Spacer()
                    }
                }
                .frame(width: buttonWidth,height: 80,alignment: .center)
                .padding()
                .offset(y: isAnimating ? 0 : 40)
                .animation(.easeOut(duration: 1), value: isAnimating)
            }//:VStack
            Spacer()
        }
        .onAppear(perform: {
            isAnimating = true
        })
    }
}

struct OnBoardingScreen_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingScreen()
    }
}
