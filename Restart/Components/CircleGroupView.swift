//
//  CircleGroupView.swift
//  Restart
//
//  Created by Meet Patel on 2023-11-06.
//

import SwiftUI

struct CircleGroupView: View {
    @State var ShapeColor:Color
    @State var ShapeOpacity: Double
    @State private var isCircleAnimating: Bool = false
    
    var body: some View {
        ZStack{
            Circle().stroke(ShapeColor.opacity(ShapeOpacity), lineWidth: 40)
                .frame(width: 260, height: 260, alignment: .center)
                
            Circle().stroke(ShapeColor.opacity(ShapeOpacity), lineWidth: 80)
                .frame(width: 260, height: 260, alignment: .center)
           
        }//:ZStack
        .blur(radius: isCircleAnimating ? 0 : 10)
        .opacity(isCircleAnimating ? 1 : 0)
        .scaleEffect(isCircleAnimating ? 1 : 0.5)
        .animation(.easeOut(duration: 1), value: isCircleAnimating)
        .onAppear(perform: {
            isCircleAnimating = true
        })
    }
}

struct CircleGroupView_Previews: PreviewProvider {
    static var previews: some View {
        CircleGroupView(ShapeColor: Color("ColorBlue"), ShapeOpacity: 0.2)
    }
}
