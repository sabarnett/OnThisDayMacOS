// Project: OnThisDay
//
//  
//

import SwiftUI

struct SidebarView: View {
    
    @AppStorage("showTotals") var showTotals = true
    @AppStorage("showBirths") var showBirths = true
    @AppStorage("showDeaths") var showDeaths = true

    @EnvironmentObject var appState: AppState
    
    @SceneStorage("selectedDate") var selectedDate: String?
    
    @Binding var selection: EventType?
    
    var validTypes: [EventType] {
        var types = [EventType.events]
        if showBirths { types.append(EventType.births) }
        if showDeaths { types.append(EventType.deaths) }
        return types
    }
    
    var body: some View {
        VStack {
            List(selection: $selection) {
                Section(selectedDate?.uppercased() ?? "TODAY") {
                    ForEach(validTypes, id: \.self) { type in
                        Text(type.rawValue)
                            .badge(
                                showTotals ? appState.countFor(eventType: type, date: selectedDate)
                                : 0
                            )
                    }
                }
                
                Section("AVAILABLE DATES") {
                    ForEach(appState.sortedDates, id: \.self) { date in
                        Button {
                            selectedDate = date
                        } label: {
                            HStack {
                                Text(date)
                                Spacer()
                            }
                        }
                        .modifier(DateButtonViewModifier(selected: selectedDate == date))
                        .controlSize(.large)
                    }
                }
            }
            
            Spacer()
            DayPicker()
        }.frame(minWidth: 220)
    }
}

struct DateButtonViewModifier: ViewModifier {
    var selected: Bool
    
    func body(content: Content) -> some View {
        if selected {
            content
                .buttonStyle(.borderedProminent)
        } else {
            content
        }
    }
}

struct SidebarView_Previews: PreviewProvider {
    static var previews: some View {
        SidebarView(selection: .constant(nil))
    }
}
