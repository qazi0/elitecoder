import SwiftUI
import Charts

struct RatingGraphView: View {
    let ratingHistory: [UserProfile.RatingChange]
    @State private var selectedRating: UserProfile.RatingChange?
    
    private var maxHistoricalRating: Int {
        ratingHistory.map(\.newRating).max() ?? 0
    }
    
    private var yAxisMaxValue: Int {
        // Add 5% buffer to the max rating for better visualization
        Int(Double(maxHistoricalRating) * 1.05)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            if #available(iOS 16.0, *) {
                Chart {
                    // Background rating ranges
                    ForEach(CodeforcesRating.backgroundRanges, id: \.min) { range in
                        RectangleMark(
                            xStart: .value("Start", ratingHistory.first?.timestamp ?? Date()),
                            xEnd: .value("End", ratingHistory.last?.timestamp ?? Date()),
                            yStart: .value("Min", range.min),
                            yEnd: .value("Max", range.max)
                        )
                        .foregroundStyle(range.color)
                    }
                    
                    // Rating line
                    ForEach(ratingHistory) { change in
                        LineMark(
                            x: .value("Date", change.timestamp),
                            y: .value("Rating", change.newRating)
                        )
                        .foregroundStyle(Color(hue: 0.1639, saturation: 1, brightness: 1))
                        .lineStyle(StrokeStyle(lineWidth: 1.3))
                    }
                    
                    // Rating points
                    ForEach(ratingHistory) { change in
                        PointMark(
                            x: .value("Date", change.timestamp),
                            y: .value("Rating", change.newRating)
                        )
                        .foregroundStyle(Color(hue: 0.1639, saturation: 1, brightness: 1))
                        .symbolSize(10)
                    }
                    
                    if let selected = selectedRating {
                        RuleMark(
                            x: .value("Selected", selected.timestamp)
                        )
                        .foregroundStyle(.gray.opacity(0.3))
                    }
                }
                .frame(height: 200)
                .chartYScale(domain: 0...yAxisMaxValue)
                .chartXAxis {
                    AxisMarks(position: .bottom)
                }
                .chartYAxis {
                    AxisMarks(position: .leading)
                }
                .chartPlotStyle { content in
                    content
                        .padding([.leading, .trailing], 0)
                        .background(Color.systemBackground)
                }
                .chartOverlay { proxy in
                    GeometryReader { geometry in
                        Rectangle()
                            .fill(.clear)
                            .contentShape(Rectangle())
                            .gesture(
                                DragGesture(minimumDistance: 0)
                                    .onChanged { value in
                                        let x = value.location.x
                                        guard let date = proxy.value(atX: x, as: Date.self) else { return }
                                        
                                        selectedRating = ratingHistory
                                            .min(by: { abs($0.timestamp.timeIntervalSince(date)) < abs($1.timestamp.timeIntervalSince(date)) })
                                    }
                                    .onEnded { _ in
                                        selectedRating = nil
                                    }
                            )
                    }
                }
                
                if let selected = selectedRating {
                    HStack {
                        Text(selected.contestName)
                            .font(.caption)
                            .lineLimit(1)
                        Spacer()
                        Text("Rating: \(selected.newRating)")
                            .font(.caption)
                            .foregroundColor(CodeforcesRating.getColor(for: selected.newRating))
                    }
                    .padding(.top, 4)
                }
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
