import SwiftUI

struct ContestsView: View {
    @StateObject private var viewModel = ContestsViewModel()
    
    var body: some View {
        NavigationView {
            List {
                Text("Upcoming Contests")
                    .font(.headline)
            }
            .navigationTitle("Contests")
        }
    }
}

struct ContestsView_Previews: PreviewProvider {
    static var previews: some View {
        ContestsView()
    }
} 