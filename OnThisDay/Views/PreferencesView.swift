// Project: OnThisDay
//
//  
//

import SwiftUI

struct PreferencesView: View {
    var body: some View {
        TabView {
            ShowPreferencesView()
                .tabItem {
                    Image(systemName: "checkmark.circle")
                    Text("Show")
                }
                .frame(width: 400, height: 220)
            
            AppearancePreferencesView()
                .tabItem {
                    Image(systemName: "sun.min")
                    Text("Appearance")
                }
                .frame(width: 300, height: 140)
        }
        
        .navigationTitle("Settings")
    }
}

struct ShowPreferencesView: View {
    @AppStorage("showBirths") var showBirths = true
    @AppStorage("showDeaths") var showDeaths = true
    @AppStorage("showTotals") var showTotals = true
    
    var body: some View {
        VStack(alignment: .leading) {
            Toggle("Show Births", isOn: $showBirths)
            Toggle("Show Deaths", isOn: $showDeaths)
            Toggle("Show Totals", isOn: $showTotals)
                .padding(.top, 15)
        }
    }
}

struct AppearancePreferencesView: View {
    
    @AppStorage("displayMode") var displayMode = DisplayMode.auto
    
    var body: some View {
        Picker("", selection: $displayMode) {
            Text("Light").tag(DisplayMode.light)
            Text("Dark").tag(DisplayMode.dark)
            Text("Auto").tag(DisplayMode.auto)
        }
        .pickerStyle(.radioGroup)
    }
}

struct PreferencesView_Previews: PreviewProvider {
    static var previews: some View {
        PreferencesView()
    }
}
