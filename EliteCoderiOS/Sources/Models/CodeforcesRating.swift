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
        Range(min: 4000, max: Int.max, title: "Tourist", color: .red, division: 1),
        Range(min: 3000, max: 3999, title: "Legendary Grandmaster", color: .red, division: 1),
        Range(min: 2600, max: 2999, title: "International Grandmaster", color: .red, division: 1),
        Range(min: 2400, max: 2599, title: "Grandmaster", color: .red, division: 1),
        Range(min: 2300, max: 2399, title: "International Master", color: .orange, division: 1),
        Range(min: 2100, max: 2299, title: "Master", color: .orange, division: 1),
        Range(min: 1900, max: 2099, title: "Candidate Master", color: Color.purple, division: 1),
        Range(min: 1600, max: 1899, title: "Expert", color: .blue, division: 2),
        Range(min: 1400, max: 1599, title: "Specialist", color: .cyan, division: 2),
        Range(min: 1200, max: 1399, title: "Pupil", color: .green, division: 2),
        Range(min: 0, max: 1199, title: "Newbie", color: Color.gray.opacity(0.5), division: 2)
    ]
    
    static let backgroundRanges: [Range] = [
        Range(min: 3000, max: 10000, title: "Legendary Grandmaster", color: Color.red.opacity(1.0), division: 1),
        Range(min: 2600, max: 2999, title: "International Grandmaster", color: Color.red.opacity(1.0), division: 1),
        Range(min: 2400, max: 2599, title: "Grandmaster", color: Color.red.opacity(1.0), division: 1),
        Range(min: 2300, max: 2399, title: "International Master", color: Color.orange.opacity(1.0), division: 1),
        Range(min: 2100, max: 2299, title: "Master", color: Color.orange.opacity(1.0), division: 1),
        Range(min: 1900, max: 2099, title: "Candidate Master", color: Color.purple.opacity(1.0), division: 1),
        Range(min: 1600, max: 1899, title: "Expert", color: Color.blue.opacity(1.0), division: 2),
        Range(min: 1400, max: 1599, title: "Specialist", color: Color.cyan.opacity(1.0), division: 2),
        Range(min: 1200, max: 1399, title: "Pupil", color: Color.green.opacity(1.0), division: 2),
        Range(min: 0, max: 1199, title: "Newbie", color: Color.gray.opacity(1.0), division: 2)
    ]
    
    static func getRatingInfo(for rating: Int) -> Range {
        ranges.first { $0.contains(rating) } ?? ranges.last!
    }
    
    // Special handling for Tourist and Legendary Grandmaster username
    static func formatUsername(_ username: String, rating: Int) -> AttributedString {
        var result = AttributedString(username)
        if rating >= 4000, let firstLetterRange = result.range(of: String(username.prefix(1))) {
            result[firstLetterRange].foregroundColor = .red
            let afterFirst = firstLetterRange.upperBound
            result[afterFirst...].foregroundColor = .black
        } else if rating >= 3000, let firstLetterRange = result.range(of: String(username.prefix(1))) {
            result[firstLetterRange].foregroundColor = .black
            let afterFirst = firstLetterRange.upperBound
            result[afterFirst...].foregroundColor = .red
        } else {
            result.foregroundColor = getColor(for: rating)
        }
        return result
    }
    
    // Special handling for Tourist and Legendary Grandmaster title
    static func formatLegendaryGrandmaster() -> AttributedString {
        var result = AttributedString("Legendary Grandmaster")
        if let firstLetterRange = result.range(of: "L") {
            result[firstLetterRange].foregroundColor = .red
            let afterFirst = firstLetterRange.upperBound
            result[afterFirst...].foregroundColor = .red
        }
        return result
    }
    
    static func getColor(for rating: Int) -> Color {
        getRatingInfo(for: rating).color
    }
} 
