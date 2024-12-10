import SwiftUI

struct UserDetailView: View {
    let handle: String
    
    var body: some View {
        ProfileView(handle: handle)
            .navigationBarTitleDisplayMode(.inline)
    }
} 