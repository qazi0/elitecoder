import SwiftUI

enum CodeforcesRating {
    struct Range {
        let min: Int
        let max: Int
        let title: String
        let color: Color
        let division: Int
        
        func contains(_ rating: Int) -> Bool {
            rating >= min && rating <= max
        }
    }
    
    static let ranges: [Range] = [
        Range(min: 2900, max: Int.max, title: "Legendary Grandmaster", color: .red, division: 1),
        Range(min: 2600, max: 2899, title: "International Grandmaster", color: .red, division: 1),
        Range(min: 2400, max: 2599, title: "Grandmaster", color: .red, division: 1),
        Range(min: 2300, max: 2399, title: "International Master", color: .orange, division: 1),
        Range(min: 2200, max: 2299, title: "Master", color: .orange, division: 1),
        Range(min: 1900, max: 2199, title: "Candidate Master", color: .purple, division: 1),
        Range(min: 1600, max: 1899, title: "Expert", color: .blue, division: 2),
        Range(min: 1400, max: 1599, title: "Specialist", color: .cyan, division: 2),
        Range(min: 1200, max: 1399, title: "Pupil", color: .green, division: 2),
        Range(min: 0, max: 1199, title: "Newbie", color: .gray, division: 2)
    ]
    
    static func getRatingInfo(for rating: Int) -> Range {
        ranges.first { $0.contains(rating) } ?? ranges.last!
    }
    
    // Special handling for Legendary Grandmaster (first letter in red)
    static func formatLegendaryGrandmaster() -> AttributedString {
        var result = AttributedString("Legendary Grandmaster")
        if let firstLetterRange = result.range(of: "L") {
            result[firstLetterRange].foregroundColor = .black
            let afterFirst = firstLetterRange.upperBound
            result[afterFirst...].foregroundColor = .red
        }
        return result
    }
    
    static func getColor(for rating: Int) -> Color {
        getRatingInfo(for: rating).color
    }
} 