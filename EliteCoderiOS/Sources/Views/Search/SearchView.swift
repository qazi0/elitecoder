import SwiftUI

// Add these imports if they're in different modules
// import Common
// import User

struct SearchView: View {
    @StateObject private var viewModel = SearchViewModel()
    
    var body: some View {
        NavigationView {
            VStack(spacing: Constants.UI.defaultPadding) {
                // Search Header
                VStack(spacing: 12) {
                    Picker("Search Type", selection: $viewModel.searchType) {
                        Text("Problems").tag(SearchType.problem)
                        Text("Users").tag(SearchType.user)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(.horizontal)
                    
                    SearchBar(
                        text: $viewModel.searchQuery,
                        placeholder: viewModel.searchType == .user ? 
                            "Enter the complete codeforces user handle" : 
                            "Search..."
                    )
                        .padding(.horizontal)
                }
                
                // Results Area
                if viewModel.isLoading {
                    ProgressView()
                } else {
                    Group {
                        switch viewModel.searchType {
                        case .problem:
                            ProblemListView(
                                problems: viewModel.searchQuery.isEmpty ? 
                                    viewModel.recentProblems : viewModel.problemResults
                            )
                        case .user:
                            VStack(spacing: 16) {
                                // Search button for user search
                                Button(action: {
                                    Task {
                                        await viewModel.performUserSearch()
                                    }
                                }) {
                                    Text("Search for \(viewModel.searchQuery)")
                                        .fontWeight(.medium)
                                        .foregroundColor(.white)
                                        .padding(.vertical, 8)
                                        .frame(maxWidth: .infinity)
                                        .background(Color.blue)
                                        .cornerRadius(10)
                                }
                                .disabled(viewModel.searchQuery.isEmpty)
                                .opacity(viewModel.searchQuery.isEmpty ? 0.5 : 1.0)
                                .padding(.horizontal)
                                
                                ScrollView {
                                    LazyVStack(spacing: 8) {
                                        ForEach(viewModel.searchResults) { user in
                                            UserCard(user: user)
                                                .padding(.horizontal)
                                        }
                                    }
                                    .padding(.vertical, 8)
                                }
                            }
                        }
                    }
                }
                
                Spacer()
            }
            .navigationTitle("Search")
        }
    }
}

// Move SearchBar to a separate file
// Move UserRowView to a separate file

struct ProblemListView: View {
    let problems: [Problem]
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 12) {
                ForEach(problems) { problem in
                    NavigationLink(destination: ProblemView(problem: problem)) {
                        ProblemCard(problem: problem)
                    }
                }
            }
            .padding()
        }
    }
}

struct ProblemCard: View {
    let problem: Problem
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(problem.name)
                .font(.headline)
            
            Text(problem.contestName)
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            Text("Rating: \(problem.rating)")
                .font(.caption)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(ratingColor(problem.rating))
                .cornerRadius(4)
            
            Text(problem.description)
                .lineLimit(2)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(radius: 2)
    }
    
    private func ratingColor(_ rating: Int) -> Color {
        // Implement rating color logic based on Codeforces colors
        .gray.opacity(0.2)
    }
} 