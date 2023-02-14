//
//  DailyWarmUpApp.swift
//  DailyWarmUp
//
//  Created by Workspace on 14/02/23.
//

import SwiftUI
import RealmSwift

@main
struct DailyWarmUpApp: SwiftUI.App {
    var body: some Scene {
        WindowGroup {
            ListScreen()
                .environment(\.realmConfiguration, .init(schemaVersion: 3))
        }
    }
}
