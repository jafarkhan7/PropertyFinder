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

typealias VoidCompletion = (()->Void)

extension View {
    func withPressableStyle(opacity: CGFloat = 0.9, scale: CGFloat = 0.9) -> some View {
        buttonStyle(ButtonStyleConfig(opacity: opacity, scale: scale))
        
    }
}

extension AnyTransition {
    static var modalPush: AnyTransition {
        .asymmetric(
            insertion: .scale(scale: 1.1).combined(with: .opacity),
            removal: .identity
        )
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

struct ToggleButtonViewModifier: ViewModifier {
    
   @State var isEnabled: Bool = true
    var selectedImageColor = Color.red
    var unselectedImageColor = Color.white
    
    func body(content: Content) -> some View {
            content
            .foregroundColor(isEnabled ? selectedImageColor : unselectedImageColor)
    }
}


extension View {
    func customFont(size: CGFloat, weight: Font.Weight? = nil) -> some View {
        modifier(CustomFontViewModifier(size: size, weight: weight))
    }
    
    func customToggle(isEnabled: Bool, selectedImageColor: Color = Color.red, unselectedImageColor: Color = Color.white) -> some View{
        modifier(ToggleButtonViewModifier(isEnabled: isEnabled, selectedImageColor: selectedImageColor, unselectedImageColor: unselectedImageColor))
    }
}

// Custom transition modifier
struct CustomTransitionModifier: ViewModifier {
    @State var opacity: Double
    @State var duration: Double
    
    @ViewBuilder func body(content: Content) -> some View {
        content
            .opacity(opacity)
            .transition (AnyTransition.scale.animation(.bouncy))
            .onAppear(perform: {
                withAnimation {
                    withAnimation(.easeIn(duration: duration)) {
                       opacity = 1
                    }
                }
            })
     }
    
}

extension View {
    func customTransition(opacity: Double, duration: Double = 0.5) -> some View {
        modifier(CustomTransitionModifier(opacity: opacity, duration: duration))
    }
}
