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