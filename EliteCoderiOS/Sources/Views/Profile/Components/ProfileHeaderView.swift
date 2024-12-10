import SwiftUI

struct ProfileHeaderView: View {
    let user: User
    let ratingInfo: CodeforcesRating.Range?
    @State private var showAllInfo = false
    
    var body: some View {
        VStack(spacing: 16) {
            // Profile Image and Basic Info
            HStack(alignment: .top, spacing: 20) {
                // Profile Image
                AsyncImage(url: URL(string: user.avatar ?? "")) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .foregroundColor(.secondary)
                }
                .frame(width: 100, height: 100)
                .clipShape(Circle())
                
                // Basic Info
                VStack(alignment: .leading, spacing: 8) {
                    if let fullName = user.fullName {
                        Text(fullName)
                            .font(.headline)
                    }
                    
                    HStack {
                        if !user.countryFlag.isEmpty {
                            Text(user.countryFlag)
                        }
                        
                        Text(user.formattedHandle)
                            .font(.title2)
                            .fontWeight(.bold)
                    }
                    
                    if let ratingInfo = ratingInfo {
                        if user.rating >= 2900 {
                            Text(CodeforcesRating.formatLegendaryGrandmaster())
                        } else {
                            Text(ratingInfo.title)
                                .foregroundColor(ratingInfo.color)
                        }
                        
                        Text("Rating: \(user.rating)")
                            .foregroundColor(ratingInfo.color)
                            .font(.headline)
                    }
                }
                
                Spacer()
            }
            
            // Rating Info
            HStack {
                StatCard(
                    title: "Rating",
                    value: "\(user.rating)",
                    subtitle: "Current",
                    isRating: true
                )
                
                StatCard(
                    title: "Max Rating",
                    value: "\(user.maxRating)",
                    subtitle: user.maxRank,
                    isRating: true
                )
            }
            
            // Additional Info (collapsible)
            VStack(alignment: .leading, spacing: 8) {
                if !showAllInfo {
                    Button("Show More...") {
                        withAnimation {
                            showAllInfo = true
                        }
                    }
                } else {
                    // Location Info
                    if user.country != nil || user.city != nil {
                        HStack {
                            Image(systemName: "location.fill")
                            if let country = user.country {
                                Text(country)
                            }
                            if let city = user.city {
                                Text(city)
                            }
                        }
                    }
                    
                    // Organization
                    if let organization = user.organization {
                        HStack {
                            Image(systemName: "building.2.fill")
                            Text(organization)
                        }
                    }
                    
                    // Contribution and Friends
                    HStack {
                        Image(systemName: "star.fill")
                        Text("Contribution: \(user.contribution)")
                    }
                    
                    HStack {
                        Image(systemName: "person.2.fill")
                        Text("Friends: \(user.friendOfCount)")
                    }
                    
                    Button("Show Less") {
                        withAnimation {
                            showAllInfo = false
                        }
                    }
                }
            }
            .padding(.top, 8)
        }
        .padding()
        .background(Color.secondarySystemBackground)
        .cornerRadius(Constants.UI.cornerRadius)
    }
} 

