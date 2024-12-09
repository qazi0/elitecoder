import SwiftUI

struct UserDetailView: View {
    let handle: String
    @StateObject private var viewModel = UserDetailViewModel()
    
    var body: some View {
        ScrollView {
            VStack(spacing: Constants.UI.defaultPadding) {
                // User Header
                userHeader
                
                // Stats Cards
                statsGrid
                
                // Recent Activity
                recentActivity
            }
            .padding()
        }
        .navigationTitle(handle)
        .task {
            await viewModel.fetchUserDetails(handle: handle)
        }
        .overlay {
            if viewModel.isLoading {
                ProgressView()
                    .background(Color.systemBackground.opacity(0.8))
            }
        }
        .alert("Error", isPresented: $viewModel.showError) {
            Button("OK", role: .cancel) {}
        } message: {
            Text(viewModel.errorMessage)
        }
    }
    
    private var userHeader: some View {
        VStack(spacing: 12) {
            Text(handle)
                .font(.title.bold())
                .foregroundColor(viewModel.user.map { CodeforcesRating.getColor(for: $0.rating) } ?? .primary)
            
            if let user = viewModel.user {
                if user.rating >= 2900 {
                    Text(CodeforcesRating.formatLegendaryGrandmaster())
                } else {
                    Text(user.rank)
                        .foregroundColor(CodeforcesRating.getColor(for: user.rating))
                }
                
                Text("Rating: \(user.rating)")
                    .font(.title3)
                    .foregroundColor(CodeforcesRating.getColor(for: user.rating))
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.secondarySystemBackground)
        .cornerRadius(Constants.UI.cornerRadius)
    }
    
    private var statsGrid: some View {
        LazyVGrid(columns: [
            GridItem(.flexible()),
            GridItem(.flexible())
        ], spacing: Constants.UI.defaultPadding) {
            if let user = viewModel.user {
                StatCard(title: "Max Rating", value: "\(user.maxRating)")
                StatCard(title: "Max Rank", value: user.maxRank.isEmpty ? "Unknown" : user.maxRank)
                // Add more stats as needed
            }
        }
    }
    
    private var recentActivity: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Recent Activity")
                .font(.headline)
            
            if let submissions = viewModel.recentSubmissions {
                ForEach(submissions) { submission in
                    SubmissionRow(submission: submission)
                }
            } else {
                Text("No recent activity")
                    .foregroundColor(.secondary)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color.secondarySystemBackground)
        .cornerRadius(Constants.UI.cornerRadius)
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