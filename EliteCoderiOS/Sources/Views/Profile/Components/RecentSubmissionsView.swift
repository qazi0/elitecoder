import SwiftUI

struct RecentSubmissionsView: View {
    let submissions: [Submission]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Recent Submissions")
                .font(.headline)
            
            ForEach(submissions) { submission in
                SubmissionRow(submission: submission)
                
                if submission.id != submissions.last?.id {
                    Divider()
                }
            }
        }
        .padding()
        .background(Color.secondarySystemBackground)
        .cornerRadius(Constants.UI.cornerRadius)
    }
} 