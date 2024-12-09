import Foundation

struct UserProfile {
    let user: User
    let statistics: UserStatistics
    let ratingHistory: [RatingChange]
    let recentActivity: [Submission]
    
    struct UserStatistics {
        let totalSolved: Int
        let contestsParticipated: Int
        let maxRating: Int
        let currentRating: Int
        let contribution: Int
        
        init(totalSolved: Int = 0,
             contestsParticipated: Int = 0,
             maxRating: Int = 0,
             currentRating: Int = 0,
             contribution: Int = 0) {
            self.totalSolved = totalSolved
            self.contestsParticipated = contestsParticipated
            self.maxRating = maxRating
            self.currentRating = currentRating
            self.contribution = contribution
        }
    }
    
    struct RatingChange: Identifiable {
        let id: Int
        let contestId: Int
        let contestName: String
        let rank: Int
        let ratingUpdate: Int
        let newRating: Int
        let timestamp: Date
        
        init(id: Int,
             contestId: Int,
             contestName: String,
             rank: Int,
             ratingUpdate: Int,
             newRating: Int,
             timestamp: Date) {
            self.id = id
            self.contestId = contestId
            self.contestName = contestName
            self.rank = rank
            self.ratingUpdate = ratingUpdate
            self.newRating = newRating
            self.timestamp = timestamp
        }
    }
    
    init(user: User, statistics: UserStatistics, ratingHistory: [RatingChange], recentActivity: [Submission]) {
        self.user = user
        self.statistics = statistics
        self.ratingHistory = ratingHistory
        self.recentActivity = recentActivity
    }
} 