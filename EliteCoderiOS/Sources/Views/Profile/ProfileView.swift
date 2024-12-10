import SwiftUI
import Charts

struct ProfileView: View {
    let handle: String
    @StateObject private var viewModel: ProfileViewModel
    
    init(handle: String = "tourist") {
        self.handle = handle
        _viewModel = StateObject(wrappedValue: ProfileViewModel())
    }
    
    var body: some View {
        ScrollView {
            if let profile = viewModel.userProfile {
                VStack(spacing: 20) {
                    // Profile Header
                    ProfileHeaderView(
                        user: profile.user,
                        ratingInfo: viewModel.ratingInfo
                    )
                    .padding(.horizontal)
                    
                    Divider()
                        .padding(.horizontal)
                    
                    // Statistics Grid
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Statistics")
                            .font(.headline)
                            .padding(.horizontal)
                        
                        StatisticsGridView(statistics: profile.statistics)
                            .padding(.horizontal)
                    }
                    
                    // Rating Graph Section
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Performance")
                            .font(.headline)
                            .padding(.horizontal)
                        
                        RatingGraphView(ratingHistory: profile.ratingHistory)
                            .padding(.horizontal)
                    }
                    
                    // Recent Activity Section
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Recent Activity")
                            .font(.headline)
                            .padding(.horizontal)
                        
                        RecentSubmissionsView(submissions: profile.recentActivity)
                            .padding(.horizontal)
                    }
                }
                .padding(.vertical)
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
            await viewModel.loadUserProfile(handle: handle)
        }
        .task {
            await viewModel.loadUserProfile(handle: handle)
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
} 