// Project: OnThisDay
//
//  
//

import SwiftUI

enum ViewMode: Int {
    case grid
    case table
}

struct ContentView: View {
    
    @EnvironmentObject var appState: AppState
    
    @SceneStorage("eventType") var eventType: EventType?
    @SceneStorage("searchText") var searchText: String = ""
    @SceneStorage("viewMode") var viewMode: ViewMode = .grid
    @SceneStorage("selectedDate") var selectedDate: String?
    
    var events: [Event] {
        appState.dataFor(eventType: eventType,
                         date: selectedDate,
                         searchText: searchText)
    }
    
    var windowTitle: String {
        if let eventType = eventType {
            return "On this day - \(eventType.rawValue) - \(selectedDate ?? "Today")"
        }
        return "On this day"
    }
    
    var body: some View {
        NavigationView {
            // Sidebar
            SidebarView(selection: $eventType)
                .frame(width: 200)
            
            // Details
            switch viewMode {
            case .grid:
                GridView(gridData: events, isFiltered: !searchText.isEmpty)
            case .table:
                TableView(tableData: events, isFiltered: !searchText.isEmpty)
            }
        }
        .searchable(text: $searchText)
        .onAppear {
            if eventType == nil {
                eventType = .events
            }
        }
        .frame(minWidth: 700, idealWidth: 1000, maxWidth: .infinity,
               minHeight: 400, idealHeight: 800, maxHeight: .infinity)
        .navigationTitle(windowTitle)
        .toolbar(id: "mainToolbar") {
            Toolbar(viewMode: $viewMode)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
