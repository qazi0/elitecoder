import SwiftUI

struct ContestCardView: View {
    let contest: Contest
    
    var body: some View {
        NavigationLink(destination: contest.isUpcoming ? nil : ContestStandingsView(contest: contest)) {
            VStack(alignment: .leading, spacing: 8) {
                Text(contest.name)
                    .font(.headline)
                    .lineLimit(2)
                
                HStack {
                    Image(systemName: "clock")
                    Text(contest.formattedStartDate)
                    Spacer()
                    Text(contest.duration)
                        .foregroundColor(.secondary)
                }
                .font(.subheadline)
                
                if contest.isUpcoming {
                    Button(action: {
                        // TODO: Implement registration
                    }) {
                        Text("Register")
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 8)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                }
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(.systemBackground))
                    .shadow(radius: 2)
            )
        }
    }
} 