import SwiftUI

struct SearchView: View {
    @StateObject private var viewModel = SearchViewModel()
    
    var body: some View {
        NavigationView {
            VStack(spacing: Constants.UI.defaultPadding) {
                SearchBar(text: $viewModel.searchQuery)
                    .padding(.horizontal)
                
                if viewModel.isLoading {
                    ProgressView()
                } else {
                    List(viewModel.searchResults) { user in
                        NavigationLink(destination: UserDetailView(handle: user.handle)) {
                            UserRowView(user: user)
                        }
                    }
                    .listStyle(PlainListStyle())
                }
            }
            .navigationTitle("Search Users")
        }
        .onChange(of: viewModel.searchQuery) { query in
            Task {
                await viewModel.searchUsers()
            }
        }
    }
}

struct SearchBar: View {
    @Binding var text: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
            
            TextField("Search users...", text: $text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)
            
            if !text.isEmpty {
                Button(action: { text = "" }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                }
            }
        }
    }
}

struct UserRowView: View {
    let user: User
    
    var body: some View {
        HStack {
            Text(user.handle)
                .font(.headline)
            Spacer()
            Text("Rating: \(user.rating)")
                .foregroundColor(.secondary)
        }
        .padding(.vertical, 8)
    }
} 