import SwiftUI
import Charts

struct RatingGraphView: View {
    let ratingHistory: [UserProfile.RatingChange]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Rating History")
                .font(.headline)
            
            if #available(iOS 16.0, *) {
                Chart(ratingHistory) { change in
                    LineMark(
                        x: .value("Date", change.timestamp),
                        y: .value("Rating", change.newRating)
                    )
                    .foregroundStyle(.blue)
                    
                    PointMark(
                        x: .value("Date", change.timestamp),
                        y: .value("Rating", change.newRating)
                    )
                    .foregroundStyle(.blue)
                }
                .frame(height: 200)
            } else {
                Text("Rating graph requires iOS 16 or later")
                    .foregroundColor(.secondary)
            }
        }
        .padding()
        .background(Color.secondarySystemBackground)
        .cornerRadius(Constants.UI.cornerRadius)
    }
} 