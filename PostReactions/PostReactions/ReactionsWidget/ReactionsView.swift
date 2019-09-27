import SwiftUI
import UIKit

struct React: Equatable {
    let name: String
    let color: Color
}

struct ReactionsView: View {
    let reactions: [React]
    let reactionSize: CGFloat
    
    init(reactions: [React], reactionSize: CGFloat = 50) {
        self.reactions = reactions
        self.reactionSize = reactionSize
    }
    
    @State private var isDragging = false {
        didSet {
            if isDragging != oldValue {
                UIImpactFeedbackGenerator().impactOccurred()
            }
        }
    }
    
    @State private var selectedReaction: React? = nil {
        didSet {
            if selectedReaction != oldValue {
                UIImpactFeedbackGenerator().impactOccurred()
            }
        }
    }
    
    private var defaultReaction: React {
        selectedReaction ?? reactions.first!
    }
    
    var body: some View {
        ZStack(alignment: .leading) {
            HStack {
                ForEach(reactions, id: \.name) {
                    Reaction(react: $0, isSelected: self.selectedReaction == $0, iconSize: self.reactionSize)
                }
            }
            .opacity(isDragging ? 1 : .zero)
            .frame(width: reactionSize, height: reactionSize)
            .offset(y: -reactionSize)
            
            ReactionSelectionButton(react: defaultReaction, size: reactionSize, onChanged: { value in
                withAnimation { self.isDragging = true }
                self.selectedReaction = self.getSelectedReaction(for: value.translation)
            }, onEnded: {
                withAnimation { self.isDragging = false }
            })
        }
    }
}

extension ReactionsView {
    func getSelectedReaction(for translation: CGSize) -> React? {
        let iconWidth = reactionSize
        let halfWidth = (iconWidth * CGFloat(reactions.count)) / 2
        let widthTranslation = translation.width + halfWidth
        let isYInRange = translation.height < (reactionSize * -0.5) && translation.height > (reactionSize * -1.5)
        
        if isYInRange {
            var iconIndex = Int(widthTranslation / iconWidth)
            if iconIndex < .zero { iconIndex = .zero }
            if iconIndex >= reactions.count { iconIndex = reactions.count - 1 }
            return reactions[iconIndex]
        }
        return nil
    }
}

struct ContentView_Previews: PreviewProvider {
    static let reactions = [
        React(name: "hand.thumbsup.fill", color: Color(red: .zero, green: 0.8, blue: 1)),
        React(name: "smiley.fill", color: .yellow),
        React(name: "flame.fill", color: .red),
        React(name: "star.fill", color: .yellow),
        React(name: "heart.fill", color: Color(red: 1, green: 0.4, blue: 0.3)),
    ]
    
    static var previews: some View {
        ReactionsView(reactions: reactions)
    }
}
