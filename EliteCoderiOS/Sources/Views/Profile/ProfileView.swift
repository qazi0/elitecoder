import SwiftUI
import Charts

struct ProfileView: View {
    @StateObject private var viewModel = ProfileViewModel()
    
    var body: some View {
        ScrollView {
            if let profile = viewModel.userProfile {
                VStack(spacing: 16) {
                    ProfileHeaderView(user: profile.user)
                    
                    // Last visit info
                    HStack {
                        Text("Last visit:")
                        Text(profile.user.lastOnlineDate, style: .relative)
                        Spacer()
                        Text("Registered:")
                        Text(profile.user.registrationDate, style: .relative)
                    }
                    .foregroundColor(.secondary)
                    .padding(.horizontal)
                    
                    // Statistics Grid
                    StatisticsGridView(statistics: profile.statistics)
                    
                    // Rating Graph
                    RatingGraphView(ratingHistory: profile.ratingHistory)
                        .frame(height: 200)
                        .padding()
                    
                    // Recent Activity
                    RecentSubmissionsView(submissions: profile.recentActivity)
                }
            } else {
                ProgressView()
            }
        }
        .navigationTitle("Profile")
        .task {
            await viewModel.loadUserProfile(handle: "tourist")
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
} 