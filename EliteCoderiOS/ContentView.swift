//
//  ContentView.swift
//  EliteCoderiOS
//
//  Created by blakberrisigma on 10/12/2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.circle")
                }
            
            ContestsView()
                .tabItem {
                    Label("Contests", systemImage: "trophy")
                }
            
            SearchView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
            
            LeaderboardView()
                .tabItem {
                    Label("Leaderboard", systemImage: "list.number")
                }
        }
        .accentColor(.blue)
    }
}

// Preview provider
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
