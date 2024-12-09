import SwiftUI

struct SubmissionRow: View {
    let submission: Submission
    var isExpanded: Bool
    
    init(submission: Submission, isExpanded: Bool = false) {
        self.submission = submission
        self.isExpanded = isExpanded
    }
    
    var body: some View {
        HStack {
            Circle()
                .fill(submission.verdict == "OK" ? Color.green : Color.red)
                .frame(width: 10, height: 10)
            
            VStack(alignment: .leading) {
                Text(submission.problemName)
                    .font(.subheadline)
                Text(submission.timeSubmitted.formatted())
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                if isExpanded {
                    Text("Language: \(submission.programmingLanguage)")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            
            Spacer()
            
            Text(submission.verdict)
                .font(.caption)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(submission.verdict == "OK" ? Color.green.opacity(0.2) : Color.red.opacity(0.2))
                .cornerRadius(Constants.UI.cornerRadius)
        }
        .padding(.vertical, 4)
    }
} 