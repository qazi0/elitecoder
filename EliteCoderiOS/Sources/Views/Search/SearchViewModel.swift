import Foundation
import Combine

class SearchViewModel: ObservableObject {
    @Published var searchQuery = ""
    @Published var searchResults: [User] = []
    @Published var isLoading = false
    
    private var cancellables = Set<AnyCancellable>()
    private let api = CodeforcesAPI.shared
    
    init() {
        setupSearchDebounce()
    }
    
    private func setupSearchDebounce() {
        $searchQuery
            .debounce(for: .milliseconds(300), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink { [weak self] query in
                if !query.isEmpty {
                    Task {
                        await self?.searchUsers()
                    }
                } else {
                    self?.searchResults = []
                }
            }
            .store(in: &cancellables)
    }
    
    @MainActor
    func searchUsers() async {
        guard !searchQuery.isEmpty else {
            searchResults = []
            return
        }
        
        isLoading = true
        do {
            let users = try await api.searchUsers(query: searchQuery)
            searchResults = users
        } catch {
            // Handle error appropriately
            print("Search error: \(error)")
            searchResults = []
        }
        isLoading = false
    }
} 