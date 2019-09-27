import SwiftUI

struct SampleView: View {
    
    let reactions = [
        React(name: "hand.thumbsup.fill", color: Color(red: 0, green: 0.8, blue: 1)),
        React(name: "smiley.fill", color: .yellow),
        React(name: "flame.fill", color: .red),
        React(name: "star.fill", color: .yellow),
        React(name: "heart.fill", color: Color(red: 1, green: 0.4, blue: 0.3)),
    ]
    
    var body: some View {
        VStack {
            Text("Reactions")
            .font(Font.custom("American Lemon", size: 90.0))
            .foregroundColor(.black)
            
            ReactionsView(reactions: reactions)
        }
        .frame(minWidth: .zero, maxWidth: .infinity, minHeight: .zero, maxHeight: .infinity)
        .background(Color(red: 1, green: 1, blue: 0.92))
        .edgesIgnoringSafeArea(.all)
    }
}

struct SampleView_Previews: PreviewProvider {
    static var previews: some View {
        SampleView()
    }
}
