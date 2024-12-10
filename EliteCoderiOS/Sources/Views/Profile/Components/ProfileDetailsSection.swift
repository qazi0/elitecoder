import SwiftUI

struct ProfileDetailsSection: View {
    let user: User
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Location Info
            if user.country != nil || user.city != nil {
                HStack {
                    Image(systemName: "location.fill")
                        .foregroundColor(.blue)
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
                        .foregroundColor(.blue)
                    Text(organization)
                }
            }
            
            // Contribution and Friends
            HStack(spacing: 16) {
                HStack {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                    Text("Contribution: \(user.contribution)")
                }
                
                HStack {
                    Image(systemName: "person.2.fill")
                        .foregroundColor(.blue)
                    Text("Friends: \(user.friendOfCount)")
                }
            }
            
            // Registration and Last Online
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Image(systemName: "calendar")
                        .foregroundColor(.blue)
                    Text("Registered: ") +
                    Text(user.registrationDate, style: .date)
                }
                
                HStack {
                    Image(systemName: "clock.fill")
                        .foregroundColor(.blue)
                    Text("Last online: ") +
                    Text(user.lastOnlineDate, style: .relative)
                }
            }
        }
        .font(.subheadline)
        .padding(.vertical, 8)
    }
} 