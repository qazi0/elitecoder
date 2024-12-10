import Foundation
import Combine

enum SearchType {
    case problem
    case user
}

class SearchViewModel: ObservableObject {
    @Published var searchType: SearchType = .problem
    @Published var searchQuery = ""
    @Published var searchResults: [User] = []
    @Published var problemResults: [Problem] = []
    @Published var recentProblems: [Problem] = []
    @Published var isLoading = false
    
    private var cancellables = Set<AnyCancellable>()
    private let api = CodeforcesAPI.shared
    
    init() {
        setupProblemSearchDebounce()
        loadRecentProblems()
    }
    
    private func setupProblemSearchDebounce() {
        $searchQuery
            .debounce(for: .milliseconds(300), scheduler: DispatchQueue.main)
            .sink { [weak self] query in
                guard let self = self, self.searchType == .problem else { return }
                Task {
                    await self.performSearch(query: query, type: .problem)
                }
            }
            .store(in: &cancellables)
    }
    
    @MainActor
    func performUserSearch() async {
        guard !searchQuery.isEmpty else { return }
        
        isLoading = true
        defer { isLoading = false }
        
        do {
            searchResults = try await api.searchUsers(query: searchQuery)
        } catch {
            print("User search error: \(error)")
            searchResults = []
        }
    }
    
    @MainActor
    private func performSearch(query: String, type: SearchType) async {
        guard !query.isEmpty else {
            searchResults = []
            problemResults = []
            return
        }
        
        isLoading = true
        defer { isLoading = false }
        
        switch type {
        case .user:
            do {
                searchResults = try await api.searchUsers(query: query)
            } catch {
                print("User search error: \(error)")
                searchResults = []
            }
            
        case .problem:
            // For now, just filter mock data
            problemResults = Problem.mockProblems.filter {
                $0.name.localizedCaseInsensitiveContains(query) ||
                $0.description.localizedCaseInsensitiveContains(query)
            }
        }
    }
    
    private func loadRecentProblems() {
        // For now, just use mock data
        recentProblems = Problem.mockProblems
    }
} 