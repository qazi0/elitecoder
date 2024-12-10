import Foundation

struct Problem: Identifiable, Codable {
    let id: String
    let contestId: Int
    let index: String
    let name: String
    let rating: Int
    let contestName: String
    let description: String
    let timeLimit: Double
    let memoryLimit: Int
    let inputFormat: String
    let outputFormat: String
    
    var fullTitle: String {
        "\(contestId)\(index) - \(name)"
    }
}

// Mock data for development
extension Problem {
    static let mockProblems = [
        Problem(
            id: "1",
            contestId: 1800,
            index: "A",
            name: "Binary Search",
            rating: 1400,
            contestName: "Codeforces Round 900",
            description: "You are given an array of n integers...",
            timeLimit: 2.0,
            memoryLimit: 256,
            inputFormat: "The first line contains two integers n and x...",
            outputFormat: "Print a single integer..."
        ),
        // Add more mock problems here
    ]
} 