import SwiftUI

struct StatisticsGridView: View {
    let statistics: UserProfile.UserStatistics
    
    var body: some View {
        LazyVGrid(columns: [
            GridItem(.flexible()),
            GridItem(.flexible())
        ], spacing: Constants.UI.defaultPadding) {
            StatisticCardView(
                title: "Problems Solved",
                value: "\(statistics.totalSolved)",
                icon: "checkmark.circle"
            )
            
            StatisticCardView(
                title: "Current Rating",
                value: "\(statistics.currentRating)",
                icon: "star.fill"
            )
            
            StatisticCardView(
                title: "Max Rating",
                value: "\(statistics.maxRating)",
                icon: "trophy.fill"
            )
            
            StatisticCardView(
                title: "Contests",
                value: "\(statistics.contestsParticipated)",
                icon: "flag.fill"
            )
        }
    }
} 