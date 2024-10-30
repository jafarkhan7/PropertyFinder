//
//  PropertyListView.swift
//  PropertyFinder
//
//  Created by Jafar khan on 13/09/2024.
//

import SwiftUI

struct PropertyListView: View {
    @StateObject private var viewModel = PropertyViewModel()
    @State var searchText: String?
    
    var body: some View {
        ScrollView {
            LazyVStack {
                SubHeaderView(propertyCount:.constant(viewModel.propertiesFiltered.count), newPropertyCount: .constant(viewModel.newPropertyCount), onToggle: { selected in
                    let propertyType =  selected == 0 ? nil : selected == 1 ? PropertyType.offPlan : PropertyType.ready
                    viewModel.getFilteredProperties(type: propertyType)
                })
                if let error = viewModel.error {
                    Text(error)
                        .offset(y:  UIScreen.height / 3)
                    
                }
                ForEach($viewModel.propertiesFiltered) { $item in
                    VStack {
                        ZStack() {
                            
                            PropertyImageView(propertyImages: item.images).frame(height: 300)
                            
                                .onAppear {
                                    // Trigger load more when the last item appears
                                    if item.id == viewModel.propertiesFiltered.last?.id {
                                        viewModel.fetchMore()
                                    }
                                }
                            
                            HStack(alignment:.top, content: {
                                PropertyFeature(isVerified: item.isVerified, isNew: item.isNew, isSuperAgent: item.isSuperAgent)
                                Spacer()
                                SystemCircleImage(
                                    isEnabled: viewModel.isFavorited(item: item),
                                    onToggle: {
                                        viewModel.setFavorite(item: item)
                                    }
                                )
                            }
                            )
                            .padding(.top)
                            .padding(.leading,10)
                            .padding(.trailing, 10)
                            
                            
                            
                            
                        }.cornerRadius(10)
                        
                        
                        PropertyTypeFeature()
                        
                        Spacer()
                    }
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                    
                    .padding()
                    
                }
                
                // Show loading indicator when loading more items
                if viewModel.isLoading {
                    ProgressView()
                        .padding()
                }
            }
        }
    }
}

struct PropertyImageView: View {
    let propertyImages: [PropertyImage]
    var body: some View {
            ZStack(alignment: .bottomLeading, content: {
                TabView {
                    ForEach(propertyImages) { image in
                        Image(image.name)
                            .resizable()
                            .scaledToFill()
                        
                    }
                }.tabViewStyle(PageTabViewStyle())
                
                AgentImageCircleView(imageName: "Ad2")
                
            })
    }
}

#Preview {
    PropertyListView()
}

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



struct SystemCircleImage: View {
    @State var isEnabled: Bool
    var onToggle: ()->Void
    var body: some View {
        
        Button(action: {
            isEnabled.toggle()
            onToggle()
        }) {
            
            ZStack {
                Circle()
                    .fill(.gray)
                    .frame(width: 50, height: 50, alignment: .center)
                Image(systemName: isEnabled ? "heart.fill" : "heart")
                    .foregroundColor(isEnabled ? .red : .white)
            }
            .customFont(size: 25)
        }
        .withPressableStyle()
        
    }
}

struct PropertyFeature: View {
    let isVerified: Bool
    let isNew: Bool
    let isSuperAgent: Bool
    
    var body: some View {
        VStack(alignment:.leading) {
            if isVerified {
                CustomTextView(imageName: "checkmark.seal", text: "VERIFIED", color: .white, backGroundColor: Color.verified, padding: 4)
                    .customFont(size: 15, weight: .bold)
                    .lineLimit(1)
                    .cornerRadius(5)
                
            }
            if isSuperAgent {
                CustomTextView(imageName: "checkmark.seal", text: "SUPERAGENT", color: .white, backGroundColor: Color.superAgent, padding: 4)
                    .customFont(size: 15, weight: .bold)
                    .lineLimit(1)
                    .cornerRadius(5)
                
            }
            if isNew {
                CustomTextView(text: "NEW", color: .white, backGroundColor: Color.customGray, padding: 4)
                    .customFont(size: 15, weight: .bold)
                    .lineLimit(1)
                    .cornerRadius(5)
                    
            }
            Spacer()
        }
    }
}

struct PropertyTypeFeature: View {
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                HStack {
                    CustomTextView(text: "Villa")
                        .customFont(size: 15, weight: .medium)
                    Spacer()
                    CustomTextView(text: "Listed 1 days ago")
                        .customFont(size: 15, weight: .medium)
                }
                Spacer(minLength: 20)
                CustomTextView(text: "2,740,000 AED", color: nil)
                    .customFont(size: 25, weight: .medium)
                Spacer(minLength: 20)
                CustomTextView(imageName: "mappin.and.ellipse", text: "Springs 11, The Springs, Dubai")
                    .customFont(size: 15, weight: .medium)
                Spacer(minLength: 20)
                HStack(alignment:.center) {
                    CustomTextView(imageName: "bed.double", text: "2")
                        .customFont(size: 15, weight: .semibold)
                    Spacer().frame(width: 20)
                    CustomTextView(imageName: "bathtub", text: "2")
                        .customFont(size: 15, weight: .semibold)

                    Spacer().frame(width: 20)
                    CustomTextView(imageName: "square.resize", text: "127 m\u{00B2}")
                        .customFont(size: 15, weight: .semibold)

                    
                }
                
                Spacer()
                
            }.padding()
            
            Divider()
            ContactPropertyView()
        }
    }
}



struct CustomTextView: View {
    var imageName: String?
    var text: String = ""
    var color : Color? = Color.gray
    var backGroundColor = Color.clear
    var padding = 0.0
    var body: some View {
        HStack() {
            
            if let imageName = imageName {
                Image(systemName: imageName).foregroundColor(color)
            }
            
            Text(text)
                .foregroundColor(color)
        }.padding(padding)
            .background(backGroundColor)
        
    }
}

struct ContactPropertyView: View {
    var body: some View {
        HStack() {
            
            Button {
                
            } label: {
                HStack(alignment: .center, spacing: 10.0, content: {
                    CustomTextView(imageName: "phone.fill", text: "Call", color: Color.superAgent)
                        .customFont(size: 12, weight: .semibold)
                        .lineLimit(1)
                    
                }).padding(0)
                    .frame(maxWidth: .infinity)
            }.padding()
                .background(Color.lightGray)
                .cornerRadius(10)
                .frame(maxWidth: .infinity)
            
            Button {
                
            } label: {
                HStack(alignment: .center, spacing: 10.0, content: {
                    CustomTextView(imageName: "message.fill", text: "WhatsApp", color: Color.superAgent)
                        .lineLimit(1)
                        .customFont(size: 12, weight: .semibold)

                    
                }).padding(0)
                    .frame(maxWidth: .infinity)
                
                
            }.padding()
                .background(Color.lightGray)
                .cornerRadius(10)
                .frame(maxWidth: .infinity)
        }.frame(maxWidth: .infinity).padding(10)
    }
}
