//
//  PropertyDetailview.swift
//  PropertyFinder
//
//  Created by Jafar on 06/10/2024.
//

import SwiftUI
import Combine

struct PropertyDetailview: View {
    
    @ObservedObject var propertyDetailsViewModel: PropertyDetailsViewModel
    @State var scrollDisabled = true
    @State var scrollPosition: CGPoint = .zero
    @State var offsetY:CGFloat = UIScreen.main.bounds.height * 0.6
    var body: some View {
        ZStack(alignment: .top, content: {
            VStack {
                ScrollView {
                    VStack(spacing: 5) {
                        ForEach(propertyDetailsViewModel.property.images) { item in
                            Image(item.name)
                                .resizable()
                                .frame(maxWidth:.infinity, maxHeight: UIScreen.height / 3)
                        }
                    }
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
                }.frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: UIScreen.height * 0.8).edgesIgnoringSafeArea(.top)
            }
            
            
            ScrollViewReader { prox in
                ModalViewDraggable(scrollDisabled: $scrollDisabled, scrollPosition: $scrollPosition, offsetY: $offsetY) {
                   

                        ModalContent(scrollDisabled: $scrollDisabled,scrollPosition: $scrollPosition, offsetY: $offsetY)
                    
                }.overlay {
                    Button {
                        withAnimation {
                            prox.scrollTo(8)

                        }
                    } label: {
                        Text("Property Finder")
                    }.offset(y: 300)

                }
            }
            
            
        })
        .setCustomView(CustomViewWrapper(view: AnyView(navigationLeft)))
        
    }
}

struct DraggableScrollView: View {
    @Binding var height: CGFloat
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                ForEach(0..<20) { index in
                    Text("Item \(index + 1)")
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                }
            }
            .padding()
        }
        .frame(width: UIScreen.width, height: height)
        .background(Color.gray.opacity(0.8))
        .cornerRadius(20)
        .shadow(radius: 10)
    }
}

extension PropertyDetailview {
    private var navigationLeft: some View {
        let size = CGSize(width: 30, height: 30)
        return  HStack {
            CircleImage(isEnabled: true, size: size, imageName: "heart.fill", imageNameDisable: "heart", selectedImageColor: .red, unselectedImageColor: .black) {
                
            }
            
            CircleImage(isEnabled: true, size: size, imageName:"arrowshape.turn.up.right", selectedImageColor: .red, unselectedImageColor: .red) {
                
            }
            
            CircleImage(isEnabled: true, size: size, imageName: "flag", selectedImageColor: .red, unselectedImageColor: .red) {
                
            }
        }.padding(.horizontal)
    }
}


//#Preview {
//    PropertyDetailview(propertyDetailsViewModel: <#PropertyDetailsViewModel#>, currentOffset: <#CGSize#>)
//}

import SwiftUI

struct ContentView: View {
    @State private var isPresented = false
    @State var currentOffset: CGSize
    @State var offset: CGSize = .zero
    @State var footerOffset = UIScreen.height - 500
    @State var scrollDisabled = true
    @State var scrollPosition: CGPoint = .zero
    @State var offsetY:CGFloat = UIScreen.main.bounds.height * 0.6
    var footerView: some View {
        Text("Offset \(offset) \n  ")
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.green)
            .cornerRadius(10)
    }
    
    
    var body: some View {
        
        
        ModalViewDraggable(scrollDisabled: $scrollDisabled, scrollPosition: $scrollPosition, offsetY: $offsetY) {
            ModalContent(scrollDisabled: $scrollDisabled,scrollPosition: $scrollPosition, offsetY: $offsetY)
        }
    }
}

struct ModalViewDraggable<Content: View>: View {
    @Binding var scrollDisabled: Bool
    @Binding var scrollPosition: CGPoint
    @Binding var offsetY:CGFloat

    var footerView: some View {
        Text("Offset : \(offsetY) \nCurrentDragOffset : \(currentDragOffset)\nEndDraggOffset:\(endDragOffset)\nEndLocationOffset:\(endLocationOffset)\nScrollPosition\(scrollPosition.y)")
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.green)
            .cornerRadius(10)
    }
    
    @State private var currentDragOffset: CGFloat = 0
    @State private var endDragOffset: CGFloat = 0
    @State private var endLocationOffset: CGFloat = 0
    
    @State private var reachedOffset = UIScreen.main.bounds.height * 0.6
    let content: () -> Content
    
    var body: some View {
        ZStack {
            content()
                .offset(y: offsetY)
                
                .gesture(DragGesture(minimumDistance: 7, coordinateSpace: .local)
                    .onChanged({ value in
                        
                        withAnimation(.spring()) {
                            
                            if offsetY <= UIScreen.height * 0.1 && value.translation.height < 0 {
                                scrollDisabled = false
                                return
                            }
                            else if  offsetY >= UIScreen.height * 0.6 && value.translation.height > 0 {
                                offsetY = UIScreen.main.bounds.height * 0.6
                            }
                            
                           
                            offsetY = reachedOffset + value.translation.height
                            
                            currentDragOffset = value.translation.height
                        }
                    })
                         
                        .onEnded({ value in
                            withAnimation {
                                endDragOffset = value.translation.height
                                endLocationOffset = value.location.y
                                if offsetY >= 330 {
                                    offsetY = UIScreen.main.bounds.height * 0.6
                                    scrollDisabled = true
                                }
                                else if offsetY <= 330 {
                                    offsetY = UIScreen.main.bounds.height * 0.1
                                    scrollDisabled = false
                                }
                                
                                reachedOffset = offsetY
                                
                            }
                            
                        })
                )
        }
        
    }
}



#Preview(body: {
    ContentView(currentOffset: .zero)
})

struct ModalContent: View {
    @Binding var scrollDisabled: Bool
    @Binding var scrollPosition: CGPoint
    @Binding var offsetY:CGFloat

    var body: some View {
        ZStack {
            VStack {
                Capsule()
                    .frame(width: 50, height: 6)
                    .padding(.top, 10)
                    ScrollView() {
                        VStack {
                            ForEach(0..<10,id: \.self) { _ in
                                Image("Ad1")
                            }
                        }
                        .background(GeometryReader { geometry in
                            Color.clear
                                .preference(key: ScrollOffsetPreferenceKey.self, value: geometry.frame(in: .named("scroll")).origin)
                        })
                        .onPreferenceChange(ScrollOffsetPreferenceKey.self) { value in
                            self.scrollPosition = value
                                                    }
                    }
                    
                    .coordinateSpace(name: "scroll")
                    
                    .scrollDisabled(scrollDisabled)
                
            }
            .frame(width: UIScreen.width)
            
            
            
        }.background(.green)
            .cornerRadius(20)
            .allowsHitTesting(true)
        
        
    }
}


#Preview(body: {
    ContentView(currentOffset: .zero)
})


#Preview(body: {
    PropertyDetailview(propertyDetailsViewModel:
                        PropertyDetailsViewModel(property: GuestDashboardViewModel().propertyViewModel.properties[0])
                        )
})
struct DetectScrollPosition: View {
    @State private var scrollPosition: CGPoint = .zero
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    ForEach((1...50), id: \.self) { row in
                        Text("Row \(row)")
                            .frame(height: 30)
                            .id(row)
                    }
                }
                .background(GeometryReader { geometry in
                    Color.clear
                        .preference(key: ScrollOffsetPreferenceKey.self, value: geometry.frame(in: .named("scroll")).origin)
                })
                .onPreferenceChange(ScrollOffsetPreferenceKey.self) { value in
                    self.scrollPosition = value
                }
            }
            .coordinateSpace(name: "scroll")
            .navigationTitle("Scroll offset: \(scrollPosition.y)")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct DetectScrollPosition_Previews: PreviewProvider {
    static var previews: some View {
        DetectScrollPosition()
    }
}

struct ScrollOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGPoint = .zero

    static func reduce(value: inout CGPoint, nextValue: () -> CGPoint) {
    }
}

#Preview(body: {
    DetectScrollPosition()
})
