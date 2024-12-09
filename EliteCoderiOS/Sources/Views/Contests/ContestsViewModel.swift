import Foundation

class ContestsViewModel: ObservableObject {
    @Published var upcomingContests: [Contest] = []
    @Published var isLoading: Bool = false
} 