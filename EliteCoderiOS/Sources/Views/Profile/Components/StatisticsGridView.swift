import SwiftUI

struct StatisticsGridView: View {
    let statistics: UserProfile.UserStatistics
    
    var body: some View {
        LazyVGrid(columns: [
            GridItem(.flexible()),
            GridItem(.flexible())
        ], spacing: Constants.UI.defaultPadding) {
            StatCard(
                title: "Current Rating",
                value: "\(statistics.currentRating)",
                subtitle: nil,
                color: nil,
                isRating: true,
                icon: "star.fill"
            )
            
            StatCard(
                title: "Max Rating",
                value: "\(statistics.maxRating)",
                subtitle: nil,
                color: nil,
                isRating: true,
                icon: "trophy.fill"
            )
            
            StatCard(
                title: "Contests",
                value: "\(statistics.contestsParticipated)",
                subtitle: nil,
                color: nil,
                isRating: false,
                icon: "flag.fill"
            )
            
            StatCard(
                title: "Contribution",
                value: "\(statistics.contribution)",
                subtitle: nil,
                color: nil,
                isRating: false,
                icon: "arrow.up.heart.fill"
            )
        }
    }
} 