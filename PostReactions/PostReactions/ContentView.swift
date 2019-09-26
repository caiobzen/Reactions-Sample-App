import SwiftUI

struct React {
    let name: String
    let color: Color
}

struct ContentView: View {
    @State var isDragging = false
    @State var selectedReaction: React? = nil
    
    private var reactions: [React] = [
        React(name: "hand.thumbsup.fill", color: Color(red: 0, green: 0.8, blue: 1)),
        React(name: "smiley.fill", color: .yellow),
        React(name: "flame.fill", color: .red),
        React(name: "star.fill", color: .yellow),
        React(name: "heart.fill", color: Color(red: 1, green: 0.4, blue: 0.3)),
    ]
    var iconSize: CGFloat = 50
    
    private var react: React {
        selectedReaction ?? reactions.first!
    }
    
    var body: some View {
        ZStack(alignment: .leading) {
            HStack {
                ForEach(reactions, id: \.name) { reaction in
                    Reaction(react: reaction, isSelected: self.selectedReaction?.name == reaction.name, iconSize: self.iconSize)
                }
            }
            .padding()
            .opacity(isDragging ? 1 : 0)
            .frame(width: iconSize, height: iconSize)
            .offset(y: -iconSize)
            
            ReactionSelectionButton(react: react, size: iconSize, onChanged: { value in
                self.isDragging = true
                self.selectedReaction = self.getSelectedReaction(for: value.translation)
            }, onEnded: {
                self.isDragging = false
            })
        }
    }
}

extension ContentView {
    func getSelectedReaction(for translation: CGSize) -> React? {
        let iconWidth = iconSize
        let halfWidth = (iconWidth * CGFloat(reactions.count)) / 2
        let widthTranslation = translation.width + halfWidth
        let isYInRange = translation.height < (iconSize * -0.5) && translation.height > (iconSize * -1.5)
        
        if isYInRange {
            var iconIndex = Int(widthTranslation / iconWidth)
            if iconIndex < 0 { iconIndex = 0 }
            if iconIndex >= reactions.count { iconIndex = reactions.count - 1 }
            return reactions[iconIndex]
        }
        return nil
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
