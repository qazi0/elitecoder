import Foundation

struct User: Codable, Identifiable {
    let id = UUID()
    let handle: String
    let rating: Int
    let rank: String
    let maxRating: Int
    let maxRank: String
    let contribution: Int
    let friendOfCount: Int
    let lastOnlineTimeSeconds: Int
    let registrationTimeSeconds: Int
    let organization: String?
    let country: String?
    let city: String?
    
    var lastOnlineDate: Date {
        Date(timeIntervalSince1970: TimeInterval(lastOnlineTimeSeconds))
    }
    
    var registrationDate: Date {
        Date(timeIntervalSince1970: TimeInterval(registrationTimeSeconds))
    }
    
    enum CodingKeys: String, CodingKey {
        case handle, rating, rank, contribution
        case maxRating = "maxRating"
        case maxRank = "maxRank"
        case friendOfCount = "friendOfCount"
        case lastOnlineTimeSeconds
        case registrationTimeSeconds
        case organization
        case country
        case city
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        handle = try container.decode(String.self, forKey: .handle)
        rating = try container.decode(Int.self, forKey: .rating)
        rank = try container.decode(String.self, forKey: .rank)
        maxRating = try container.decode(Int.self, forKey: .maxRating)
        maxRank = try container.decodeIfPresent(String.self, forKey: .maxRank) ?? "Unranked"
        contribution = try container.decode(Int.self, forKey: .contribution)
        friendOfCount = try container.decode(Int.self, forKey: .friendOfCount)
        lastOnlineTimeSeconds = try container.decode(Int.self, forKey: .lastOnlineTimeSeconds)
        registrationTimeSeconds = try container.decode(Int.self, forKey: .registrationTimeSeconds)
        organization = try container.decodeIfPresent(String.self, forKey: .organization)
        country = try container.decodeIfPresent(String.self, forKey: .country)
        city = try container.decodeIfPresent(String.self, forKey: .city)
    }
} 