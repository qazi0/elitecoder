import Foundation

struct Submission: Identifiable, Codable {
    let id: Int
    let contestId: Int
    let problemName: String
    let verdict: String
    let timeSubmitted: Date
    let programmingLanguage: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case contestId
        case problem
        case verdict
        case creationTimeSeconds
        case programmingLanguage
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        contestId = try container.decode(Int.self, forKey: .contestId)
        
        let problem = try container.nestedContainer(keyedBy: ProblemKeys.self, forKey: .problem)
        problemName = try problem.decode(String.self, forKey: .name)
        
        verdict = try container.decode(String.self, forKey: .verdict)
        let timestamp = try container.decode(Int.self, forKey: .creationTimeSeconds)
        timeSubmitted = Date(timeIntervalSince1970: TimeInterval(timestamp))
        programmingLanguage = try container.decode(String.self, forKey: .programmingLanguage)
    }
    
    enum ProblemKeys: String, CodingKey {
        case name
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(contestId, forKey: .contestId)
        try container.encode(verdict, forKey: .verdict)
        try container.encode(Int(timeSubmitted.timeIntervalSince1970), forKey: .creationTimeSeconds)
        try container.encode(programmingLanguage, forKey: .programmingLanguage)
        
        var problem = container.nestedContainer(keyedBy: ProblemKeys.self, forKey: .problem)
        try problem.encode(problemName, forKey: .name)
    }
} 