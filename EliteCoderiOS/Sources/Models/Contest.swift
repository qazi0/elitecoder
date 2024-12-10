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
    
    var endDate: Date {
        startDate.addingTimeInterval(TimeInterval(durationSeconds))
    }
    
    var duration: String {
        let hours = durationSeconds / 3600
        let minutes = (durationSeconds % 3600) / 60
        if minutes == 0 {
            return "\(hours)h"
        }
        return "\(hours)h \(minutes)m"
    }
    
    var isUpcoming: Bool {
        phase == "BEFORE"
    }
    
    var formattedStartDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yy HH:mm"
        return formatter.string(from: startDate)
    }
} 