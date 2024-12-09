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
                Text(user.handle)
                    .font(.headline)
                Text("\(user.rating) points")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
        }
        .padding(.vertical, 8)
    }
} 