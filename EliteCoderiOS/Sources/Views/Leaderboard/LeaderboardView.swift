import SwiftUI

struct LeaderboardView: View {
    @StateObject private var viewModel = LeaderboardViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                if viewModel.isLoading {
                    ProgressView()
                } else if let error = viewModel.error {
                    VStack {
                        Text("Error loading leaderboard")
                            .foregroundColor(.red)
                        Text(error.localizedDescription)
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Button("Retry") {
                            Task {
                                await viewModel.fetchTopUsers()
                            }
                        }
                        .buttonStyle(.bordered)
                    }
                } else {
                    List {
                        ForEach(Array(viewModel.topUsers.enumerated()), id: \.element.id) { index, user in
                            NavigationLink(destination: UserDetailView(handle: user.handle)) {
                                LeaderboardRowView(user: user, rank: index + 1)
                            }
                        }
                    }
                    .refreshable {
                        await viewModel.forceRefresh()
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