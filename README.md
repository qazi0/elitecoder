# EliteCoder iOS app

![App Icon](./EliteCoderiOS/Assets.xcassets/AppIcon.appiconset/elite2-trans.png)

A modern, native iOS application for Codeforces - the popular competitive programming platform. Built with SwiftUI, featuring a clean architecture and real-time integration with the Codeforces API.

## Features

### 🏆 Contest Tracking
- Live upcoming and ongoing contest listings
- Detailed contest standings with real-time updates
- Contest problem sets with integrated problem viewer
- Support for both Div. 1 and Div. 2 contests

### 👤 User Profiles
- Comprehensive user statistics and ratings
- Interactive rating graph with historical data
- Recent submissions and activity tracking
- Support for legendary grandmaster special styling
- Country flags and organization details
- Profile sharing capabilities

### 🔍 Problem Search & Viewing
- Search problems by contest ID and index
- Integrated problem viewer with native iOS styling
- Problem difficulty indicators
- Support for problem statements, samples, and constraints
- Recent problems list

### 📊 Leaderboard
- Global user rankings
- Rating-based user categorization
- Cached data for improved performance
- Pull-to-refresh functionality

### 🎨 User Interface
- Native iOS design patterns
- Dynamic color theming based on Codeforces rating system
- Smooth animations and transitions
- Support for both light and dark modes
- Responsive layout for all iOS devices

## Technical Details

### Architecture
- **Language**: Swift 5.5+
- **UI Framework**: SwiftUI
- **Minimum iOS Version**: iOS 15.0
- **Design Pattern**: MVVM (Model-View-ViewModel)
- **State Management**: Combine framework
- **Networking**: URLSession with async/await
- **Charts**: Swift Charts (iOS 16+)

### Codeforces API Integration
The app uses the following Codeforces API endpoints:
- `/user.info`
- `/user.rating`
- `/user.status`
- `/contest.list`
- `/contest.standings`
- `/problemset.problems`

### Data Models
- Comprehensive model layer with Codable conformance
- Efficient caching mechanisms
- Type-safe enums for ratings and contests
- Custom JSON parsing for complex API responses

### Performance Optimizations
- Efficient data caching
- Lazy loading of images and content
- Debounced API calls for search
- Pagination support for large datasets
- Memory-efficient collection views

### Security
- Secure API communication
- URL encoding for user inputs
- Error handling and validation
- Rate limiting compliance

## Installation

1. Clone the repository
```swift
git clone https://github.com/qazi0/elitecoder.git
```

2. Open the project in Xcode
```
cd elitecoder
open EliteCoderiOSApp.xcodeproj
```

3. Build and run the project

## Requirements
- Xcode 14.0+
- iOS 15.0+
- Swift 5.5+
 