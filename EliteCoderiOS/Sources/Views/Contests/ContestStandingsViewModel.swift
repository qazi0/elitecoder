import Foundation

class ContestStandingsViewModel: ObservableObject {
    @Published var standings: [ContestStanding] = []
    @Published var problems: [ContestProblem] = []
    @Published var isLoading = false
    @Published var error: Error?
    @Published var userRatings: [String: Int] = [:]
    
    func fetchStandings(for contestId: Int) {
        isLoading = true
        
        Task {
            do {
                let standings = try await CodeforcesAPI.shared.fetchContestStandings(contestId: contestId)
                
                let handles = standings.rows.map { $0.handle }
                let users = try await CodeforcesAPI.shared.fetchUsers(handles: handles)
                let ratings = Dictionary(uniqueKeysWithValues: users.map { ($0.handle, $0.rating ?? 0) })
                
                DispatchQueue.main.async {
                    self.standings = standings.rows
                    self.problems = standings.problems
                    self.userRatings = ratings
                    self.isLoading = false
                }
            } catch {
                DispatchQueue.main.async {
                    self.error = error
                    self.isLoading = false
                }
            }
        }
    }
} 