import SwiftUI

struct LeaderboardView: View {
    @StateObject private var viewModel = LeaderboardViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                if viewModel.isLoading {
                    ProgressView()
                } else {
                    List {
                        ForEach(viewModel.topUsers) { user in
                            NavigationLink(destination: UserDetailView(handle: user.handle)) {
                                if let rank = viewModel.topUsers.firstIndex(where: { $0.id == user.id }) {
                                    LeaderboardRowView(user: user, rank: rank + 1)
                                } else {
                                    Text("Rank not found")
                                }
                            }
                        }
                    }
                    .refreshable {
                        await viewModel.fetchTopUsers()
                    }
                }
            }
            .navigationTitle("Leaderboard")
            .task {
                await viewModel.fetchTopUsers()
            }
        }
    }
}

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
                Text("Rating: \(user.rating)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Text(user.rank)
                .font(.caption)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(ratingColor(for: user.rating))
                .cornerRadius(Constants.UI.cornerRadius)
                .foregroundColor(.white)
        }
        .padding(.vertical, 4)
    }
    
    private func ratingColor(for rating: Int) -> Color {
        switch rating {
        case ..<1200: return .gray
        case 1200..<1400: return .green
        case 1400..<1600: return .blue
        case 1600..<1900: return .purple
        case 1900..<2100: return .orange
        case 2100..<2400: return .red
        default: return .black
        }
    }
} 