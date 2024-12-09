import SwiftUI
import Charts

struct ActivityChartView: View {
    let activityData: [(Date, Int)]
    @Binding var timeRange: ProfileViewModel.TimeRange
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text("Activity")
                    .font(.headline)
                
                Spacer()
                
                Picker("Time Range", selection: $timeRange) {
                    ForEach(ProfileViewModel.TimeRange.allCases, id: \.self) { range in
                        Text(range.rawValue).tag(range)
                    }
                }
                .pickerStyle(.segmented)
            }
            
            if #available(iOS 16.0, *) {
                Chart(activityData, id: \.0) { day, count in
                    BarMark(
                        x: .value("Date", day),
                        y: .value("Submissions", count)
                    )
                    .foregroundStyle(.blue)
                }
                .frame(height: 200)
            } else {
                Text("Activity chart requires iOS 16 or later")
                    .foregroundColor(.secondary)
            }
        }
        .padding()
        .background(Color.secondarySystemBackground)
        .cornerRadius(Constants.UI.cornerRadius)
    }
} 