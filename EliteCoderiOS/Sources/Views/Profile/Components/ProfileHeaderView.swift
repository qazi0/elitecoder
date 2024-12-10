import SwiftUI

struct ProfileHeaderView: View {
    let user: User
    let ratingInfo: CodeforcesRating.Range?
    @State private var showAllInfo = false
    
    var body: some View {
        VStack(spacing: 16) {
            // Profile Image and Basic Info
            HStack(alignment: .top, spacing: 20) {
                // Profile Image with animation
                AsyncImage(url: URL(string: user.avatar ?? "")) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .transition(.opacity)
                } placeholder: {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .foregroundColor(.secondary)
                }
                .frame(width: 100, height: 100)
                .clipShape(Circle())
                .overlay(Circle().stroke(ratingInfo?.color ?? .gray, lineWidth: 2))
                .shadow(radius: 5)
                
                // Basic Info with improved typography
                VStack(alignment: .leading, spacing: 8) {
                    if let fullName = user.fullName {
                        Text(fullName)
                            .font(.headline)
                            .foregroundColor(.secondary)
                    }
                    
                    HStack {
                        if !user.countryFlag.isEmpty {
                            Text(user.countryFlag)
                                .font(.title2)
                        }
                        
                        Text(user.formattedHandle)
                            .font(.title)
                            .fontWeight(.bold)
                    }
                    
                    if let ratingInfo = ratingInfo {
                        if user.rating >= 3000 {
                            Text(CodeforcesRating.formatLegendaryGrandmaster())
                                .font(.headline)
                        } else {
                            Text(ratingInfo.title)
                                .font(.headline)
                                .foregroundColor(ratingInfo.color)
                        }
                    }
                }
                
                Spacer()
                
                // Share button
                Button(action: shareProfile) {
                    Image(systemName: "square.and.arrow.up")
                        .imageScale(.large)
                }
                .buttonStyle(.bordered)
            }
            
            // Rating cards with animation
            HStack(spacing: 16) {
                RatingCard(
                    rating: user.rating,
                    title: "Current Rating",
                    color: ratingInfo?.color ?? .gray
                )
                .transition(.scale)
                
                RatingCard(
                    rating: user.maxRating,
                    title: "Max Rating",
                    color: CodeforcesRating.getColor(for: user.maxRating)
                )
                .transition(.scale)
            }
            
            // Additional info section
            if showAllInfo {
                ProfileDetailsSection(user: user)
                    .transition(.opacity)
            }
            
            Button(showAllInfo ? "Show Less" : "Show More...") {
                withAnimation {
                    showAllInfo.toggle()
                }
            }
        }
        .padding()
        .background(Color.secondarySystemBackground)
        .cornerRadius(Constants.UI.cornerRadius)
    }
    
    private func shareProfile() {
        guard let url = URL(string: "https://codeforces.com/profile/\(user.handle)") else { return }
        let activityVC = UIActivityViewController(
            activityItems: [url],
            applicationActivities: nil
        )
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first,
           let rootVC = window.rootViewController {
            rootVC.present(activityVC, animated: true)
        }
    }
} 

