import Foundation

struct Contest: Codable, Identifiable {
    let id: Int
    let name: String
    let type: String
    let phase: String
    let startTimeSeconds: Int
    let durationSeconds: Int
    
    var startDate: Date {
        Date(timeIntervalSince1970: TimeInterval(startTimeSeconds))
    }
} 