import SwiftUI

struct ReactionSelectionButton: View {
    let react: React
    let size: CGFloat
    let onChanged: (DragGesture.Value) -> Void
    let onEnded: () -> Void
    
    var body: some View {
        Image(systemName: react.name)
            .font(.system(size: 20))
            .foregroundColor(react.color)
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { self.onChanged($0) }
                    .onEnded { _ in self.onEnded() }
            )
        .frame(width: size, height: size)
    }
}


struct ReactionSelectionButton_Previews: PreviewProvider {
    static var previews: some View {
        ReactionSelectionButton(react: React(name: "heart.fill", color: .red), size: 50, onChanged: { value in
             print("changed \(value)")
            }, onEnded: {
            print("onEnded")
        })
        .previewLayout(.fixed(width: 100, height: 100))
    }
}
