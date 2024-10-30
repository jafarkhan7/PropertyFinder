//
//  Utils.swift
//  PropertyFinder
//
//  Created by Jafar khan on 19/09/2024.
//

import SwiftUI

struct ButtonStyleConfig: ButtonStyle {
    
    let opacity: CGFloat
    let scale: CGFloat
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? scale : 1.0)
            .opacity(configuration.isPressed ? 0.5 : 1)
            .onChange(of: configuration.isPressed) { isPressed,_ in
                if isPressed {
                    let generator = UIImpactFeedbackGenerator(style: .heavy)
                    generator.impactOccurred()
                }
                
            }
        
    }
}

extension View {
    func withPressableStyle(opacity: CGFloat = 0.9, scale: CGFloat = 0.9) -> some View {
        buttonStyle(ButtonStyleConfig(opacity: opacity, scale: scale))
        
    }
}


extension UIScreen {
    static var width: CGFloat {
        UIScreen.main.bounds.width
    }
    
    static var height: CGFloat {
        UIScreen.main.bounds.height
    }
}


extension Color {
    
    static var verified: Color {
        Color(hex: "3B7E4C")
    }
    static var superAgent: Color {
        Color(hex: "54469A")
    }
    static var new: Color {
        Color(hex: "595958")
    }
    
    static var customGray: Color {
        Color(hex: "A4A4A7")
    }
    static var lightGray: Color {
        Color(hex: "F7F6FA")
    }
    //    let myColor: Color = #colorLiteral(red: 0.3403233886, green: 0.2719218433, blue: 0.6248556972, alpha: 1)
    
    
    init(hex: String) {
        let r, g, b: Double
        
        // Clean up the hex string
        var hexColor = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexColor = hexColor.replacingOccurrences(of: "#", with: "")
        
        // Check if it's 3 or 6 digits
        let scanner = Scanner(string: hexColor)
        if hexColor.count == 6 {
            var hexNumber: UInt64 = 0
            scanner.scanHexInt64(&hexNumber)
            
            r = Double((hexNumber & 0xFF0000) >> 16) / 255
            g = Double((hexNumber & 0x00FF00) >> 8) / 255
            b = Double(hexNumber & 0x0000FF) / 255
        } else if hexColor.count == 3 {
            var hexNumber: UInt64 = 0
            scanner.scanHexInt64(&hexNumber)
            
            r = Double((hexNumber & 0xF00) >> 8) / 15
            g = Double((hexNumber & 0x0F0) >> 4) / 15
            b = Double(hexNumber & 0x00F) / 15
        } else {
            r = 0
            g = 0
            b = 0
        }
        
        self.init(red: r, green: g, blue: b)
    }
}


struct CustomFontViewModifier: ViewModifier {
    
    @Environment(\.sizeCategory) var scaleFactor
    
    
    let size: CGFloat
    let weight: Font.Weight?
    
    func body(content: Content) -> some View {
        switch scaleFactor {
        case .extraSmall, .small,.medium:
            content.font(Font.system(size: size, weight: weight))
        case .large, .extraLarge,.extraExtraLarge:
            content.font(Font.system(size: size + 5, weight: weight))
        default:  content.font(Font.system(size: size + 7, weight: weight))
        }
    }
}


extension View {
    func customFont(size: CGFloat, weight: Font.Weight? = nil) -> some View {
        modifier(CustomFontViewModifier(size: size, weight: weight))
    }
}


struct MenuDropDown<Content: View>: View {
    let menuItem: [String]
    let labelContent: Content
    @Binding var selectedIndex: Int

    init(menuItem: [String], selectedIndex: Binding<Int>, @ViewBuilder labelContent: () -> Content) {
        self.menuItem = menuItem
        self._selectedIndex = selectedIndex
        self.labelContent = labelContent()
    }
    
    var body: some View {

        Menu(content: {
            ForEach(menuItem.indices, id: \.self) { index in
                Button(action: {
                    selectedIndex = index
                }) {
                    HStack {
                        Text(menuItem[index])
                        if selectedIndex == index {
                            Image(systemName: "checkmark") // Checkmark icon
                                .foregroundColor(.blue) // Change color if selected
                        }
                    }
                }
            }
            
        }, label: {
            labelContent
        })

        
    }
}
