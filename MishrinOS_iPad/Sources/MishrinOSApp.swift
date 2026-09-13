import SwiftUI

@main
struct MishrinOSApp: App {
    var body: some Scene {
        WindowGroup { ContentView() }
    }
}

struct ContentView: View {
    @State private var showGiftPrompt = true
    private let sections = ["Home", "Study", "AI", "Files", "Browser", "Notes", "Calendar", "Tasks", "Settings"]
    private let studyApps = ["Khan Academy", "Coursera", "edX", "Udemy", "Duolingo", "Quizlet", "Google Classroom", "Notion"]
    private let aiApps = ["ChatGPT", "Claude", "Gemini", "Perplexity", "Copilot", "Grok", "DeepSeek"]

    var body: some View {
        NavigationSplitView {
            List(sections, id: \.self) { Text($0) }
                .navigationTitle("Mishrin OS")
        } detail: {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Mishrin OS").font(.largeTitle.bold())
                    Text("Compressed • Intelligent • Yours").foregroundStyle(.cyan)
                    Text("Study, AI and productivity in one compact iPad workspace.").foregroundStyle(.secondary)

                    if showGiftPrompt {
                        VStack(alignment: .leading, spacing: 12) {
                            Label("Mishrin's Gift OS", systemImage: "sparkles").font(.headline)
                            Text("A new unified study and AI experience is available.").foregroundStyle(.secondary)
                            HStack {
                                Button("Download / Update") {
                                    if let url = URL(string: "https://apps.apple.com/") { UIApplication.shared.open(url) }
                                }.buttonStyle(.borderedProminent)
                                Button("Later") { showGiftPrompt = false }.buttonStyle(.bordered)
                            }
                        }.padding().background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 18))
                    }

                    appGrid(title: "Study & Learning", apps: studyApps)
                    appGrid(title: "AI & Assistants", apps: aiApps)
                    appGrid(title: "Productivity", apps: ["Notion", "Google Workspace", "Microsoft 365", "Todoist", "Slack"])
                    appGrid(title: "Development", apps: ["VS Code", "GitHub", "Replit", "Jupyter", "Terminal"])
                }.padding()
            }
            .background(Color.black.ignoresSafeArea())
            .preferredColorScheme(.dark)
        }
    }

    @ViewBuilder
    private func appGrid(title: String, apps: [String]) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title).font(.headline)
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 130))], spacing: 10) {
                ForEach(apps, id: \.self) { app in
                    Text(app).frame(maxWidth: .infinity, minHeight: 44)
                        .background(Color.white.opacity(0.07), in: RoundedRectangle(cornerRadius: 12))
                }
            }
        }.padding().background(Color.white.opacity(0.04), in: RoundedRectangle(cornerRadius: 18))
    }
}
