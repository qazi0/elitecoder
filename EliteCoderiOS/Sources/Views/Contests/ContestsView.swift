import SwiftUI

struct ContestsView: View {
    @StateObject private var viewModel = ContestsViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                if viewModel.isLoading {
                    ProgressView()
                        .padding()
                } else {
                    VStack(spacing: 24) {
                        upcomingContestsSection
                        recentContestsSection
                    }
                    .padding()
                }
            }
            .navigationTitle("Contests")
            .refreshable {
                viewModel.fetchContests()
            }
        }
        .onAppear {
            viewModel.fetchContests()
        }
    }
    
    private var upcomingContestsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Upcoming Contests")
                .font(.title2)
                .bold()
            
            if viewModel.upcomingContests.isEmpty {
                Text("No upcoming contests")
                    .foregroundColor(.secondary)
            } else {
                LazyVStack(spacing: 12) {
                    ForEach(viewModel.upcomingContests) { contest in
                        ContestCardView(contest: contest)
                    }
                }
            }
        }
    }
    
    private var recentContestsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Recent Contests")
                .font(.title2)
                .bold()
            
            if viewModel.recentContests.isEmpty {
                Text("No recent contests")
                    .foregroundColor(.secondary)
            } else {
                LazyVStack(spacing: 12) {
                    ForEach(viewModel.recentContests) { contest in
                        ContestCardView(contest: contest)
                    }
                }
            }
        }
    }
}

struct ContestsView_Previews: PreviewProvider {
    static var previews: some View {
        ContestsView()
    }
} 