import Foundation

@MainActor
class UserDetailViewModel: ObservableObject {
    @Published var user: User?
    @Published var recentSubmissions: [Submission]?
    @Published var isLoading = false
    @Published var showError = false
    @Published var errorMessage = ""
    
    private let api = CodeforcesAPI.shared
    
    func fetchUserDetails(handle: String) async {
        isLoading = true
        
        do {
            async let userTask = api.fetchUser(handle: handle)
            async let submissionsTask = api.fetchUserSubmissions(handle: handle)
            
            let (user, submissions) = try await (userTask, submissionsTask)
            self.user = user
            self.recentSubmissions = submissions.prefix(10).map { $0 }
        } catch {
            showError = true
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
} 