import SwiftUI

struct StatCard: View {
    let title: String
    let value: String
    let subtitle: String?
    let color: Color?
    let isRating: Bool
    let icon: String?
    
    init(
        title: String,
        value: String,
        subtitle: String? = nil,
        color: Color? = nil,
        isRating: Bool = false,
        icon: String? = nil
    ) {
        self.title = title
        self.value = value
        self.subtitle = subtitle
        self.color = color
        self.isRating = isRating
        self.icon = icon
    }
    
    var body: some View {
        VStack(spacing: 8) {
            // Title with optional icon
            if let icon = icon {
                HStack {
                    Image(systemName: icon)
                        .foregroundColor(.blue)
                    Text(title)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            } else {
                Text(title)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            // Value
            Text(value)
                .font(.title3.bold())
                .foregroundColor(isRating ? CodeforcesRating.getColor(for: Int(value) ?? 0) : color)
            
            // Optional subtitle
            if let subtitle = subtitle {
                Text(subtitle)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.secondarySystemBackground)
        .cornerRadius(Constants.UI.cornerRadius)
    }
} 