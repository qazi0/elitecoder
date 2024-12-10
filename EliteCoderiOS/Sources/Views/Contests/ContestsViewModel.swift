import Foundation

class ContestsViewModel: ObservableObject {
    @Published var upcomingContests: [Contest] = []
    @Published var recentContests: [Contest] = []
    @Published var isLoading: Bool = false
    @Published var error: Error?
    
    func fetchContests() {
        isLoading = true
        
        guard let url = URL(string: "https://codeforces.com/api/contest.list?gym=false") else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            DispatchQueue.main.async {
                self?.isLoading = false
                
                if let error = error {
                    self?.error = error
                    return
                }
                
                guard let data = data else { return }
                
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(CodeforcesResponse.self, from: data)
                    
                    self?.upcomingContests = response.result
                        .filter { $0.isUpcoming }
                        .sorted { $0.startTimeSeconds < $1.startTimeSeconds }
                    
                    self?.recentContests = response.result
                        .filter { !$0.isUpcoming }
                        .sorted { $0.startTimeSeconds > $1.startTimeSeconds }
                        .prefix(10)
                        .map { $0 }
                    
                } catch {
                    self?.error = error
                }
            }
        }.resume()
    }
}

struct CodeforcesResponse: Codable {
    let status: String
    let result: [Contest]
} 