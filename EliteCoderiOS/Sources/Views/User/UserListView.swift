import SwiftUI

struct UserListView: View {
    let users: [User]
    
    var body: some View {
        List(users) { user in
            NavigationLink(destination: UserDetailView(handle: user.handle)) {
                UserRowView(user: user)
            }
        }
        .listStyle(PlainListStyle())
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