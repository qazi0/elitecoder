import Foundation

class LeaderboardViewModel: ObservableObject {
    @Published var topUsers: [User] = []
    @Published var isLoading = false
    
    private let api = CodeforcesAPI.shared
    
    @MainActor
    func fetchTopUsers() async {
        isLoading = true
        do {
            // In a real implementation, we would use a specific API endpoint for top users
            // For now, we'll use a mock implementation
            topUsers = try await api.fetchTopUsers()
        } catch {
            print("Error fetching top users: \(error)")
        }
        isLoading = false
    }
} 