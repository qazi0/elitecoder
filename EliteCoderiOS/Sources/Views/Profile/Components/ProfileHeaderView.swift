import SwiftUI

struct ProfileHeaderView: View {
    let user: User
    
    var body: some View {
        VStack(spacing: 16) {
            HStack(alignment: .top) {
                // Profile Image
                AsyncImage(url: URL(string: "https://userpic.codeforces.org/user/\(user.handle)/photo")) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .foregroundColor(.secondary)
                }
                .frame(width: 120, height: 120)
                .clipShape(Circle())
                
                // User Info
                VStack(alignment: .leading, spacing: 8) {
                    Text(user.rank)
                        .font(.headline)
                        .foregroundColor(.red)
                    
                    Text(user.handle)
                        .font(.title)
                        .fontWeight(.bold)
                    
                    if let organization = user.organization {
                        Text("From \(organization)")
                            .foregroundColor(.secondary)
                    }
                    
                    HStack {
                        if let country = user.country {
                            Text(country)
                        }
                        if let city = user.city {
                            Text("•")
                            Text(city)
                        }
                    }
                    .foregroundColor(.secondary)
                }
                
                Spacer()
            }
            
            // Rating and Stats
            HStack(spacing: 24) {
                VStack(alignment: .leading) {
                    Text("Contest rating")
                        .foregroundColor(.secondary)
                    HStack {
                        Text("\(user.rating)")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(ratingColor(for: user.rating))
                        Text("(max. \(user.maxRating))")
                            .foregroundColor(.secondary)
                    }
                }
                
                VStack(alignment: .leading) {
                    Text("Contribution")
                        .foregroundColor(.secondary)
                    Text(formatContribution(user.contribution))
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(user.contribution >= 0 ? .green : .red)
                }
                
                VStack(alignment: .leading) {
                    Text("Friend of")
                        .foregroundColor(.secondary)
                    Text("\(user.friendOfCount) users")
                        .font(.title2)
                        .fontWeight(.bold)
                }
            }
            .padding(.horizontal)
            
            Divider()
        }
        .padding()
    }
    
    private func formatContribution(_ contribution: Int) -> String {
        return contribution >= 0 ? "+\(contribution)" : "\(contribution)"
    }
    
    private func ratingColor(for rating: Int) -> Color {
        switch rating {
        case ..<1200: return .gray
        case 1200..<1400: return .green
        case 1400..<1600: return .cyan
        case 1600..<1900: return .blue
        case 1900..<2100: return .purple
        case 2100..<2400: return Color(red: 1, green: 0.6, blue: 0) // Orange
        case 2400..<3000: return .red
        default: return Color(red: 0.7, green: 0, blue: 0) // Dark red
        }
    }
} 