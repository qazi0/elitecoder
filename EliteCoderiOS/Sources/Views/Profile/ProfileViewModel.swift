import Foundation
import SwiftUI

@MainActor
class ProfileViewModel: ObservableObject {
    @Published var userProfile: UserProfile?
    @Published var isLoading = false
    @Published var error: Error?
    @Published var selectedTimeRange: TimeRange = .month
    @Published var ratingInfo: CodeforcesRating.Range?
    
    private let api = CodeforcesAPI.shared
    
    enum TimeRange: String, CaseIterable {
        case week = "Week"
        case month = "Month"
        case year = "Year"
    }
    
    func loadUserProfile(handle: String) async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            async let userTask = api.fetchUser(handle: handle)
            async let ratingsTask = api.fetchUserRating(handle: handle)
            async let submissionsTask = api.fetchUserSubmissions(handle: handle)
            
            let (user, ratings, submissions) = try await (userTask, ratingsTask, submissionsTask)
            
            // Get rating info
            self.ratingInfo = CodeforcesRating.getRatingInfo(for: user.rating)
            
            // Calculate statistics
            let statistics = UserProfile.UserStatistics(
                contestsParticipated: ratings.count,
                maxRating: user.maxRating,
                currentRating: user.rating,
                contribution: user.contribution
            )
            
            // Convert API rating changes to our model
            let ratingHistory = ratings.map { rating in
                UserProfile.RatingChange(
                    id: rating.id,
                    contestId: rating.contestId,
                    contestName: rating.contestName,
                    rank: rating.rank,
                    ratingUpdate: rating.ratingUpdate,
                    newRating: rating.newRating,
                    timestamp: rating.timestamp
                )
            }
            
            // Create user profile
            userProfile = UserProfile(
                user: user,
                statistics: statistics,
                ratingHistory: ratingHistory,
                recentActivity: Array(submissions.prefix(10))
            )
        } catch {
            self.error = error
            print("Error loading profile: \(error)")
        }
    }
    
    var activityData: [(Date, Int)] {
        guard let submissions = userProfile?.recentActivity else { return [] }
        
        let calendar = Calendar.current
        let now = Date()
        let startDate: Date
        
        switch selectedTimeRange {
        case .week:
            startDate = calendar.date(byAdding: .day, value: -7, to: now) ?? now
        case .month:
            startDate = calendar.date(byAdding: .month, value: -1, to: now) ?? now
        case .year:
            startDate = calendar.date(byAdding: .year, value: -1, to: now) ?? now
        }
        
        return submissions
            .filter { $0.timeSubmitted >= startDate }
            .reduce(into: [:]) { counts, submission in
                let day = calendar.startOfDay(for: submission.timeSubmitted)
                counts[day, default: 0] += 1
            }
            .sorted { $0.key < $1.key }
            .map { ($0.key, $0.value) }
    }
} 