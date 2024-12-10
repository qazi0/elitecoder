import Foundation

class LeaderboardViewModel: ObservableObject {
    @Published var topUsers: [User] = []
    @Published var isLoading = false
    @Published var error: Error?
    
    private let api = CodeforcesAPI.shared
    
    // Cache configuration
    private static var cache: [User] = []
    private static var lastFetchTime: Date?
    private static let cacheValidityDuration: TimeInterval = 5 * 60 // 5 minutes
    
    @MainActor
    func fetchTopUsers() async {
        // Check if cache is valid
        if let lastFetch = Self.lastFetchTime,
           Date().timeIntervalSince(lastFetch) < Self.cacheValidityDuration,
           !Self.cache.isEmpty {
            self.topUsers = Self.cache
            return
        }
        
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
                let users = Array(response.result.prefix(100))
                self.topUsers = users
                // Update cache
                Self.cache = users
                Self.lastFetchTime = Date()
            } else {
                throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid response status"])
            }
        } catch {
            self.error = error
            print("Error fetching top users: \(error)")
        }
        isLoading = false
    }
    
    // Method to force refresh the cache
    @MainActor
    func forceRefresh() async {
        Self.lastFetchTime = nil
        Self.cache = []
        await fetchTopUsers()
    }
} 