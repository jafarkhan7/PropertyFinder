//
//  AgentImageCircleView.swift
//  PropertyFinder
//
//  Created by Jafar on 24/10/2024.
//

import SwiftUI

struct AgentImageCircleView: View {
    var imageName: String?
    
    var body: some View {
        ZStack(alignment: .topTrailing, content:
                {
            Image(imageName ?? "")
                .resizable()
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.superAgent, lineWidth: 2.5))
                .frame(width: 50, height:50)
                .padding(10)
            
            ZStack(alignment: .center, content: {
                Circle().fill(Color.superAgent)
                    .frame(width: 25, height: 25)
                Image(systemName: "star.fill").resizable()
                    .foregroundColor(.white)
                    .frame(width: 15, height: 15)
                
            })
            
            .overlay(Circle().stroke(.purple, lineWidth: /*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/))
            .frame(width: 20, height:20).offset(x:-5,y:5)
        })
    }
}

#Preview {
    AgentImageCircleView()
}
