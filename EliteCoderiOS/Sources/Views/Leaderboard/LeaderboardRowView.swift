import SwiftUI

struct LeaderboardRowView: View {
    let user: User
    let rank: Int
    
    var body: some View {
        HStack(spacing: Constants.UI.defaultPadding) {
            Text("#\(rank)")
                .font(.headline)
                .foregroundColor(.secondary)
                .frame(width: 40)
            
            VStack(alignment: .leading) {
                Text(user.handle)
                    .font(.headline)
                    .foregroundColor(CodeforcesRating.getColor(for: user.rating))
                
                Text("Rating: \(user.rating)")
                    .font(.subheadline)
                    .foregroundColor(CodeforcesRating.getColor(for: user.rating))
            }
            
            Spacer()
            
            Text(user.rank)
                .font(.caption)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(CodeforcesRating.getColor(for: user.rating))
                .cornerRadius(Constants.UI.cornerRadius)
                .foregroundColor(.white)
        }
        .padding(.vertical, 4)
    }
} 