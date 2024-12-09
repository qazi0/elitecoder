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
        
        struct Response: Codable {
            let status: String
            let result: [UserProfile.RatingChange]
        }
        
        let decodedResponse = try JSONDecoder().decode(Response.self, from: data)
        return decodedResponse.result
    }
} 