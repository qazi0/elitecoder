import Foundation
import SwiftUI

struct User: Codable, Identifiable {
    let id = UUID()
    let handle: String
    let firstName: String?
    let lastName: String?
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
    let avatar: String?
    let titlePhoto: String?
    
    var fullName: String? {
        if let firstName = firstName, let lastName = lastName {
            return "\(firstName) \(lastName)"
        }
        return firstName ?? lastName
    }
    
    var lastOnlineDate: Date {
        Date(timeIntervalSince1970: TimeInterval(lastOnlineTimeSeconds))
    }
    
    var registrationDate: Date {
        Date(timeIntervalSince1970: TimeInterval(registrationTimeSeconds))
    }
    
    var ratingColor: Color {
        CodeforcesRating.getColor(for: rating)
    }
    
    var formattedHandle: AttributedString {
        CodeforcesRating.formatUsername(handle, rating: rating)
    }
    
    var countryFlag: String {
        CountryFlag.flag(for: country)
    }
    
    enum CodingKeys: String, CodingKey {
        case handle, rating, rank, contribution
        case firstName, lastName
        case maxRating = "maxRating"
        case maxRank = "maxRank"
        case friendOfCount = "friendOfCount"
        case lastOnlineTimeSeconds
        case registrationTimeSeconds
        case organization
        case country
        case city
        case avatar
        case titlePhoto
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        handle = try container.decode(String.self, forKey: .handle)
        firstName = try container.decodeIfPresent(String.self, forKey: .firstName)
        lastName = try container.decodeIfPresent(String.self, forKey: .lastName)
        rating = try container.decode(Int.self, forKey: .rating)
        rank = try container.decode(String.self, forKey: .rank).lowercased()
        maxRating = try container.decode(Int.self, forKey: .maxRating)
        maxRank = try container.decodeIfPresent(String.self, forKey: .maxRank)?.lowercased() ?? "unranked"
        contribution = try container.decode(Int.self, forKey: .contribution)
        friendOfCount = try container.decode(Int.self, forKey: .friendOfCount)
        lastOnlineTimeSeconds = try container.decode(Int.self, forKey: .lastOnlineTimeSeconds)
        registrationTimeSeconds = try container.decode(Int.self, forKey: .registrationTimeSeconds)
        organization = try container.decodeIfPresent(String.self, forKey: .organization)
        country = try container.decodeIfPresent(String.self, forKey: .country)
        city = try container.decodeIfPresent(String.self, forKey: .city)
        avatar = try container.decodeIfPresent(String.self, forKey: .avatar)
        titlePhoto = try container.decodeIfPresent(String.self, forKey: .titlePhoto)
    }
} 