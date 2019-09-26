import SwiftUI

struct Reaction: View {
    let react: React
    let isSelected: Bool
    let iconSize: CGFloat
    
    var body: some View {
        Image(systemName: react.name)
            .font(.system(size: 20))
            .frame(width: iconSize, height: iconSize)
            .animation(.spring())
            .scaleEffect(isSelected ? 1.3 : 1.0)
            .background(isSelected ? Color.black : .clear)
            .foregroundColor(isSelected ? react.color : .black)
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
