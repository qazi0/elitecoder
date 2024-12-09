import Foundation

class LeaderboardViewModel: ObservableObject {
    @Published var topUsers: [User] = []
    @Published var isLoading = false
    @Published var error: Error?
    
    private let api = CodeforcesAPI.shared
    
    @MainActor
    func fetchTopUsers() async {
        isLoading = true
        do {
            let url = URL(string: "https://codeforces.com/api/user.ratedList?activeOnly=true&includeRetired=false")!
            let (data, _) = try await URLSession.shared.data(from: url)
            
            struct Response: Codable {
                let status: String
                let result: [User]
            }
            
            let response = try JSONDecoder().decode(Response.self, from: data)
            if response.status == "OK" {
                // Take only first 100 users
                topUsers = Array(response.result.prefix(100))
            } else {
                throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid response status"])
            }
        } catch {
            self.error = error
            print("Error fetching top users: \(error)")
        }
        isLoading = false
    }
} 