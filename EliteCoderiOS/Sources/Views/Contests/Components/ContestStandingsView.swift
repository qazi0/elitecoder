import SwiftUI

struct ContestStandingsView: View {
    let contest: Contest
    @StateObject private var viewModel = ContestStandingsViewModel()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                contestHeader
                if viewModel.isLoading {
                    ProgressView()
                        .padding()
                } else {
                    standingsTable
                }
            }
            .padding()
        }
        .navigationTitle("Final Standings")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            viewModel.fetchStandings(for: contest.id)
        }
    }
    
    private var contestHeader: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(contest.name)
                .font(.headline)
            
            HStack {
                Image(systemName: "calendar")
                Text(contest.formattedStartDate)
                Spacer()
                Text(contest.duration)
                    .foregroundColor(.secondary)
            }
            .font(.subheadline)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.systemBackground))
                .shadow(radius: 2)
        )
    }
    
    private var standingsTable: some View {
        VStack(spacing: 12) {
            HStack {
                Text("Rank")
                    .frame(width: 50, alignment: .leading)
                Text("Handle")
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text("Score")
                    .frame(width: 80, alignment: .trailing)
                Text("Solved")
                    .frame(width: 60, alignment: .trailing)
            }
            .font(.subheadline)
            .foregroundColor(.secondary)
            
            ForEach(viewModel.standings) { standing in
                StandingRowView(
                    standing: standing,
                    userRating: viewModel.userRatings[standing.handle] ?? 0
                )
            }
        }
    }
}

struct StandingRowView: View {
    let standing: ContestStanding
    let userRating: Int
    
    var body: some View {
        HStack {
            Text("\(standing.rank)")
                .frame(width: 50, alignment: .leading)
                .foregroundColor(rankColor)
            
            Text(standing.handle)
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(CodeforcesRating.getColor(for: userRating))
            
            Text(String(format: "%.0f", standing.points))
                .frame(width: 80, alignment: .trailing)
            
            Text("\(standing.problemsSolved)")
                .frame(width: 60, alignment: .trailing)
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 12)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(Color(.systemBackground))
                .shadow(radius: 1)
        )
    }
    
    private var rankColor: Color {
        switch standing.rank {
        case 1: return .yellow
        case 2: return .gray
        case 3: return .brown
        default: return .primary
        }
    }
} 