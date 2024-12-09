import Foundation

struct UserProfile: Codable {
    let user: User
    let statistics: UserStatistics
    let ratingHistory: [RatingChange]
    let recentActivity: [Submission]
    
    struct UserStatistics: Codable {
        let totalSolved: Int
        let contestsParticipated: Int
        let maxRating: Int
        let currentRating: Int
        let contribution: Int
    }
    
    struct RatingChange: Codable, Identifiable {
        let id: Int
        let contestId: Int
        let contestName: String
        let rank: Int
        let ratingUpdate: Int
        let newRating: Int
        let timestamp: Date
        
        enum CodingKeys: String, CodingKey {
            case id = "id"
            case contestId = "contestId"
            case contestName
            case rank
            case ratingUpdate = "oldRating"
            case newRating
            case timestamp = "ratingUpdateTimeSeconds"
        }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let contestId = try container.decode(Int.self, forKey: .contestId)
            self.id = contestId
            self.contestId = contestId
            contestName = try container.decode(String.self, forKey: .contestName)
            rank = try container.decode(Int.self, forKey: .rank)
            newRating = try container.decode(Int.self, forKey: .newRating)
            ratingUpdate = try container.decode(Int.self, forKey: .ratingUpdate)
            let timeSeconds = try container.decode(Int.self, forKey: .timestamp)
            timestamp = Date(timeIntervalSince1970: TimeInterval(timeSeconds))
        }
    }
} 