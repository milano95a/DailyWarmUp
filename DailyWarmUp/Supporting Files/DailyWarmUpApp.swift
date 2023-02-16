
import SwiftUI

@main
struct DailyWarmUpApp: App {
    
    
    var body: some Scene {
        WindowGroup {
            TopicListScreen()
                .environment(\.realmConfiguration, .init(schemaVersion: 3))
        }
    }
}
