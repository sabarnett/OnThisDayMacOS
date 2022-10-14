// Project: OnThisDay
//
//  
//

import SwiftUI

struct Toolbar: CustomizableToolbarContent {
    
    @Binding var viewMode: ViewMode
    
    var body: some CustomizableToolbarContent {
        ToolbarItem(id: "toggleSidebar",
                    placement: .navigation,
                    showsByDefault: true) {
            tbButton("Toggle Sidebar", systemImage: "sidebar.left", help: "Toggle Sidebar") {
                toggleSidebar()
            }
        }
        
        ToolbarItem(id: "toggleViewMode",
                    showsByDefault: true) {
            Picker("View Mode", selection: $viewMode) {
                Label("Grid", systemImage: "square.grid.3x2").tag(ViewMode.grid)
                Label("Table", systemImage: "tablecells").tag(ViewMode.table)
            }
            .pickerStyle(.segmented)
            .help("Switch view style between grid and table")
        }
    }
    
    func toggleSidebar() {
        NSApp.keyWindow?
            .contentViewController?
            .tryToPerform(#selector(NSSplitViewController.toggleSidebar(_:)), with: nil)
    }
    
    func tbButton(_ caption: String, systemImage: String, help: String, action: @escaping ()->Void ) -> some View {
        Button {
           action()
        } label: {
            Label(caption, systemImage: systemImage)
        }
        .help(help)
    }
}

