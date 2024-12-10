import SwiftUI

struct ProblemView: View {
    let problem: Problem
    @Environment(\.openURL) private var openURL
    @State private var showingCopiedAlert = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Header
                VStack(alignment: .leading, spacing: 8) {
                    Text(problem.name)
                        .font(.title)
                        .bold()
                    
                    Text(problem.contestName)
                        .font(.headline)
                        .foregroundColor(.secondary)
                    
                    HStack {
                        ProblemInfoBadge(
                            icon: "clock",
                            text: "\(problem.timeLimit)s"
                        )
                        
                        ProblemInfoBadge(
                            icon: "memorychip",
                            text: "\(problem.memoryLimit)MB"
                        )
                        
                        ProblemInfoBadge(
                            icon: "star.fill",
                            text: "\(problem.rating)"
                        )
                    }
                }
                
                Divider()
                
                // Problem Content
                VStack(alignment: .leading, spacing: 12) {
                    Text("Problem Statement")
                        .font(.headline)
                    
                    Text(problem.description)
                        .font(.body)
                    
                    Group {
                        Text("Input")
                            .font(.headline)
                        Text(problem.inputFormat)
                        
                        Text("Output")
                            .font(.headline)
                        Text(problem.outputFormat)
                    }
                }
                
                // Actions
                HStack {
                    Button(action: copyToClipboard) {
                        Label("Copy", systemImage: "doc.on.doc")
                    }
                    
                    Spacer()
                    
                    Button(action: openInBrowser) {
                        Label("Open in Browser", systemImage: "safari")
                    }
                }
                .padding(.top)
            }
            .padding()
        }
        .alert("Copied to Clipboard", isPresented: $showingCopiedAlert) {
            Button("OK", role: .cancel) { }
        }
    }
    
    private func copyToClipboard() {
        UIPasteboard.general.string = problem.description
        showingCopiedAlert = true
    }
    
    private func openInBrowser() {
        if let url = URL(string: "https://codeforces.com/problemset/problem/\(problem.contestId)/\(problem.index)") {
            openURL(url)
        }
    }
}

struct ProblemInfoBadge: View {
    let icon: String
    let text: String
    
    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: icon)
                .font(.caption)
            Text(text)
                .font(.caption)
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .background(Color.secondary.opacity(0.2))
        .cornerRadius(4)
    }
} 