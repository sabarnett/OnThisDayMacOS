// Project: OnThisDay
//
//  
//

import SwiftUI

struct TableView: View {
    
    var tableData: [Event]
    var isFiltered: Bool
    
    @AppStorage("showTotals") var showTotals = true

    @State private var sortOrder = [KeyPathComparator(\Event.year)]
    @State private var selectedEventId: UUID?
    //@State private var selectedEventId: Set<UUID> = []
    
    var sortedTableData: [Event] {
        return tableData.sorted(using: sortOrder)
    }
    
    var selectedEvent: Event? {
        guard let selectedEventId = selectedEventId else { return nil }
        return tableData.first { $0.id == selectedEventId }
    }
    
    var body: some View {

        VStack {
            if showTotals && isFiltered {
                Text("\(sortedTableData.count) items found.")
                    .font(.title3)
                    .foregroundColor(.primary)
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 0)
                    .padding(.vertical, 10)
                    .background(Color(.systemGray).opacity(0.5))
                    .shadow(color: Color(.systemGray), radius: 3, x: 3, y: 3)
            }
            HStack {
                Table(sortedTableData,
                      selection: $selectedEventId,
                      sortOrder: $sortOrder) {
                    TableColumn("Year", value: \.year) {
                        Text($0.year)
                    }
                    .width(min: 50, ideal: 50, max: 100)
                    
                    TableColumn("Title", value: \.text)
                }.tableStyle(.bordered)
                
                if let selectedEvent = selectedEvent {
                    EventView(event: selectedEvent)
                        .frame(width: 250)
                }
            }
        }
    }
}

struct TableView_Previews: PreviewProvider {
    static var previews: some View {
        TableView(tableData: [Event.sampleEvent, Event.sampleEvent], isFiltered: true)
    }
}
