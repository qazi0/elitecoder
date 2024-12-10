import SwiftUI

struct UserCard: View {
    let user: User
    
    private var ratingInfo: CodeforcesRating.Range {
        CodeforcesRating.getRatingInfo(for: user.rating)
    }
    
    var body: some View {
        NavigationLink(destination: ProfileView(handle: user.handle)) {
            HStack(spacing: 16) {
                // Rating badge
                Text("\(user.rating)")
                    .font(.system(.subheadline, design: .rounded))
                    .fontWeight(.medium)
                    .foregroundColor(ratingInfo.color)
                    .frame(width: 60)
                    .padding(.vertical, 4)
                    .background(ratingInfo.color.opacity(0.15))
                    .cornerRadius(6)
                
                VStack(alignment: .leading, spacing: 4) {
                    // Handle
                    Text(user.handle)
                        .font(.system(.body, design: .rounded))
                        .fontWeight(.medium)
                        .foregroundColor(CodeforcesRating.getColor(for: user.rating))
                    
                    // Title (rank)
                    if user.rating >= 3000 {
                        Text(CodeforcesRating.formatLegendaryGrandmaster())
                            .font(.subheadline)
                    } else {
                        Text(ratingInfo.title)
                            .font(.subheadline)
                            .foregroundColor(ratingInfo.color)
                    }
                }
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
                    .font(.system(.footnote, weight: .medium))
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(Color(.systemBackground))
            .cornerRadius(8)
            .shadow(color: Color.black.opacity(0.05), radius: 2, x: 0, y: 1)
        }
    }
} 
