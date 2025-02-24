import Foundation

enum APIError: Error {
    case invalidURL
    case networkError
    case decodingError
    case apiError(String)
}

class CodeforcesAPI {
    static let shared = CodeforcesAPI()
    private let baseURL = Constants.API.baseURL
    
    private init() {}
    
    func fetchUser(handle: String) async throws -> User {
        guard let encodedHandle = handle.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: "\(baseURL)/user.info?handles=\(encodedHandle)") else {
            throw APIError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw APIError.networkError
        }
        
        struct Response: Codable {
            let status: String
            let result: [User]
        }
        
        let decodedResponse = try JSONDecoder().decode(Response.self, from: data)
        guard let user = decodedResponse.result.first else {
            throw APIError.decodingError
        }
        
        return user
    }
    
    func fetchContests() async throws -> [Contest] {
        guard let url = URL(string: "\(baseURL)/contest.list") else {
            throw APIError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw APIError.networkError
        }
        
        struct Response: Codable {
            let status: String
            let result: [Contest]
        }
        
        let decodedResponse = try JSONDecoder().decode(Response.self, from: data)
        return decodedResponse.result
    }
    
    func searchUsers(query: String) async throws -> [User] {
        guard let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: "\(baseURL)/user.info?handles=\(encodedQuery)") else {
            throw APIError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw APIError.networkError
        }
        
        struct Response: Codable {
            let status: String
            let result: [User]
        }
        
        let decodedResponse = try JSONDecoder().decode(Response.self, from: data)
        return decodedResponse.result
    }
    
    func fetchUserSubmissions(handle: String) async throws -> [Submission] {
        guard let encodedHandle = handle.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: "\(baseURL)/user.status?handle=\(encodedHandle)&from=1&count=10") else {
            throw APIError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw APIError.networkError
        }
        
        struct Response: Codable {
            let status: String
            let result: [Submission]
        }
        
        let decodedResponse = try JSONDecoder().decode(Response.self, from: data)
        return decodedResponse.result
    }
    
    func fetchTopUsers() async throws -> [User] {
        let topHandles = ["tourist", "Petr", "Um_nik", "jiangly", "ecnerwala"].joined(separator: ";")
        guard let url = URL(string: "\(baseURL)/user.info?handles=\(topHandles)") else {
            throw APIError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw APIError.networkError
        }
        
        struct Response: Codable {
            let status: String
            let result: [User]
        }
        
        let decodedResponse = try JSONDecoder().decode(Response.self, from: data)
        return decodedResponse.result
    }
    
    func fetchUserRating(handle: String) async throws -> [UserProfile.RatingChange] {
        guard let encodedHandle = handle.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: "\(baseURL)/user.rating?handle=\(encodedHandle)") else {
            throw APIError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw APIError.networkError
        }
        
        // Create a separate type for API response
        struct APIRatingChange: Codable {
            let contestId: Int
            let contestName: String
            let rank: Int
            let oldRating: Int
            let newRating: Int
            let ratingUpdateTimeSeconds: Int
        }
        
        struct Response: Codable {
            let status: String
            let result: [APIRatingChange]
        }
        
        let decodedResponse = try JSONDecoder().decode(Response.self, from: data)
        
        // Map API response to our model
        return decodedResponse.result.map { apiRating in
            UserProfile.RatingChange(
                id: apiRating.contestId,
                contestId: apiRating.contestId,
                contestName: apiRating.contestName,
                rank: apiRating.rank,
                ratingUpdate: apiRating.newRating - apiRating.oldRating,
                newRating: apiRating.newRating,
                timestamp: Date(timeIntervalSince1970: TimeInterval(apiRating.ratingUpdateTimeSeconds))
            )
        }
    }
    
    func fetchContestStandings(contestId: Int, from: Int = 1, count: Int = 100) async throws -> Contest.Standings {
        guard let url = URL(string: "\(baseURL)/contest.standings?contestId=\(contestId)&from=\(from)&count=\(count)") else {
            throw APIError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw APIError.networkError
        }
        
        struct Response: Codable {
            let status: String
            let result: Contest.Standings
        }
        
        let decodedResponse = try JSONDecoder().decode(Response.self, from: data)
        return decodedResponse.result
    }
    
    func fetchUsers(handles: [String]) async throws -> [User] {
        // Join handles with semicolons and limit to chunks of 100 handles
        let handleChunks = handles.chunked(into: 100)
        var allUsers: [User] = []
        
        for chunk in handleChunks {
            let handlesString = chunk.joined(separator: ";")
            guard let encodedHandles = handlesString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
                  let url = URL(string: "\(baseURL)/user.info?handles=\(encodedHandles)") else {
                throw APIError.invalidURL
            }
            
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200 else {
                throw APIError.networkError
            }
            
            struct Response: Codable {
                let status: String
                let result: [User]
            }
            
            let decodedResponse = try JSONDecoder().decode(Response.self, from: data)
            allUsers.append(contentsOf: decodedResponse.result)
        }
        
        return allUsers
    }
}

private extension Array {
    func chunked(into size: Int) -> [[Element]] {
        stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
} 