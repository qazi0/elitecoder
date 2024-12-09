import SwiftUI

struct LeaderboardRowView: View {
    let user: User
    let rank: Int
    
    var body: some View {
        HStack {
            Text("#\(rank)")
                .font(.headline)
                .foregroundColor(.secondary)
                .frame(width: 50)
            
            AsyncImage(url: URL(string: user.avatar ?? "")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                Image(systemName: "person.circle.fill")
                    .resizable()
            }
            .frame(width: 40, height: 40)
            .clipShape(Circle())
            
            VStack(alignment: .leading) {
                HStack(spacing: 4) {
                    if !user.countryFlag.isEmpty {
                        Text(user.countryFlag)
                    }
                    Text(user.formattedHandle)
                        .font(.headline)
                    Text("\(user.rating)")
                        .font(.subheadline)
                        .foregroundColor(user.ratingColor)
                }
            }
            
            Spacer()
        }
        .padding(.vertical, 8)
    }
} 
