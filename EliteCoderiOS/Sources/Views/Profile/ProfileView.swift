import SwiftUI
import Charts

struct ProfileView: View {
    @StateObject private var viewModel = ProfileViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                if let profile = viewModel.userProfile {
                    VStack(spacing: 16) {
                        ProfileHeaderView(
                            user: profile.user,
                            ratingInfo: viewModel.ratingInfo
                        )
                        
                        Divider()
                        
                        // Statistics Grid
                        StatisticsGridView(statistics: profile.statistics)
                        
                        // Rating Graph
                        RatingGraphView(ratingHistory: profile.ratingHistory)
                            .frame(height: 200)
                        
                        // Recent Activity
                        RecentSubmissionsView(submissions: profile.recentActivity)
                    }
                    .padding()
                } else if viewModel.isLoading {
                    ProgressView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else if let error = viewModel.error {
                    ContentUnavailableView(
                        "Failed to Load Profile",
                        systemImage: "exclamationmark.triangle",
                        description: Text(error.localizedDescription)
                    )
                }
            }
            .navigationTitle("Profile")
            .refreshable {
                await viewModel.loadUserProfile(handle: "tourist")
            }
            .task {
                await viewModel.loadUserProfile(handle: "tourist")
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
} 