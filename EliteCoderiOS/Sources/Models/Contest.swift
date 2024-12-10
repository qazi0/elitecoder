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

struct ContestProblem: Codable, Identifiable {
    let contestId: Int
    let index: String
    let name: String
    let type: String
    let points: Int
    let rating: Int?
    
    var id: String { "\(contestId)\(index)" }
}

struct ContestStanding: Codable, Identifiable {
    struct Party: Codable {
        struct Member: Codable {
            let handle: String
        }
        let members: [Member]
        
        var uniqueId: String {
            members.map { $0.handle }.joined(separator: "_")
        }
    }
    
    struct ProblemResult: Codable {
        let points: Double
        let rejectedAttemptCount: Int
        let bestSubmissionTimeSeconds: Int?
    }
    
    let party: Party
    let rank: Int
    let points: Double
    let problemResults: [ProblemResult]
    
    var id: String { "\(rank)_\(party.uniqueId)" }
    var handle: String { party.members.first?.handle ?? "" }
    var problemsSolved: Int {
        problemResults.filter { $0.points > 0 }.count
    }
}

extension Contest {
    struct Standings: Codable {
        let contest: Contest
        let problems: [ContestProblem]
        let rows: [ContestStanding]
    }
} 