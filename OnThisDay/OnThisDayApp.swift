// Project: OnThisDay
//
//  
//

import SwiftUI

@main
struct OnThisDayApp: App {
    
    @AppStorage("displayMode") var displayMode = DisplayMode.auto
    
    @StateObject var appState = AppState()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appState)
                .onAppear {
                    DisplayMode.changeDisplayMode(to: displayMode)
                }
                .onChange(of: displayMode) { newValue in
                    DisplayMode.changeDisplayMode(to: newValue)
                }
        }
        .commands {
            Menus()
        }
        Settings {
            PreferencesView()
        }
    }
}
