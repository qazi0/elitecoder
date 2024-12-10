import SwiftUI

struct RatingCard: View {
    let rating: Int
    let title: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 4) {
            Text(String(rating))
                .font(.system(size: 32, weight: .bold))
                .foregroundColor(color)
            
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: Constants.UI.cornerRadius)
                .fill(Color.systemBackground)
                .shadow(color: color.opacity(0.2), radius: 5)
        )
    }
} 