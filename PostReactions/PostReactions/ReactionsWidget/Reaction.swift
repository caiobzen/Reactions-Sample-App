import SwiftUI

struct Reaction: View {
    let react: React
    let isSelected: Bool
    let iconSize: CGFloat
    let scaledRatio: CGFloat
    
    init(react: React, isSelected: Bool, iconSize: CGFloat, scaledRatio: CGFloat = 1.5) {
        self.react = react
        self.isSelected = isSelected
        self.iconSize = iconSize
        self.scaledRatio = scaledRatio
    }
    
    var body: some View {
        Image(systemName: react.name)
            .frame(width: iconSize, height: iconSize)
            .animation(.spring())
            .scaleEffect(isSelected ? scaledRatio : 1.0)
            .foregroundColor(isSelected ? react.color : .black)
            .background(isSelected ? Color.black : .clear)
            .clipShape(Circle())
    }
}

struct Reaction_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Reaction(react: React(name: "heart.fill", color: .red), isSelected: true, iconSize: 50)
            
            Reaction(react: React(name: "heart.fill", color: .red), isSelected: false, iconSize: 50)
        }
        .previewLayout(.fixed(width: 100, height: 100))
    }
}
