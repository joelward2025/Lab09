//
//  ContentView.swift
//  Lab09
//
//  Created by Joel Ward on 10/25/24.
//

import SwiftUI

private func randomX(for size: CGSize) -> CGFloat {
    CGFloat(Double.random(in: 0..<Double(size.width)))
}

struct ContentView: View {
    @State var blockX = randomX(for: UIScreen.main.bounds.size)
    @Namespace private var animation
    @State private var isPressed = false
    @State private var offset = 0
    
    var body: some View {
        GeometryReader { geometry in
            ZStack{
                VStack {
                    Rectangle()
                        .fill(.green)
                        .frame(width: 50, height: 50)
                        .position(CGPoint(x: blockX,y:0))
                    Spacer()
                }
                .padding()
                VStack {
                    Spacer()
                    HStack{
                        Spacer()
                        Button("<"){
                            if (!isPressed){
                                offset -= 10
                            }
                        }
                        Spacer()
                        Button("Reset"){
                            blockX = randomX(for: geometry.size)
                            isPressed = false
                            offset = 0
                        }
                        Spacer()
                        Button("Shoot"){
                            withAnimation() {
                                isPressed = true
                            }
                        }
                        Spacer()
                        Button(">"){
                            if (!isPressed){
                                offset += 10
                            }
                        }
                        Spacer()
                    }
                }
                VStack {
                    if !isPressed {
                        Circle()
                            .matchedGeometryEffect(id: "ball", in: animation)
                            .frame(width: 20)
                            .position(CGPoint(x: geometry.size.width/2, y: geometry.size.height * 0.95))
                    }
                    else {
                        Circle()
                            .matchedGeometryEffect(id: "ball", in: animation)
                            .frame(width: 20)
                            .position(CGPoint(x: geometry.size.width/2 + CGFloat(offset), y: geometry.size.height * 0.025))
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
