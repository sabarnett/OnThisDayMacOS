// Project: OnThisDay
//
//  
//

import SwiftUI

struct GridView: View {
    
    @AppStorage("showTotals") var showTotals = true
    
    var gridData: [Event]
    var isFiltered: Bool
    var columns: [GridItem] {
        [GridItem(.adaptive(minimum: 250, maximum: 250), spacing: 20)]
    }
    
    var body: some View {
        VStack {
            if showTotals && isFiltered {
                Text("\(gridData.count) items found.")
                    .font(.title3)
                    .foregroundColor(.primary)
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 0)
                    .padding(.vertical, 10)
                    .background(Color(.systemGray).opacity(0.5))
                    .shadow(color: Color(.systemGray), radius: 3, x: 3, y: 3)
            }
            ScrollView {
                LazyVGrid(columns: columns, spacing: 15) {
                    ForEach(gridData) { datum in
                        EventView(event: datum)
                            .frame(height: 350, alignment: .topLeading)
                            .background()
                            .clipped()
                            .border(.secondary, width: 1)
                            .padding(.bottom, 5)
                            .shadow(color: .primary.opacity(0.3), radius: 3, x: 3, y: 3)
                    }
                }
            }.padding(.vertical)
        }
    }
}

struct GridView_Previews: PreviewProvider {
    static var previews: some View {
        GridView(gridData: [Event.sampleEvent, Event.sampleEvent], isFiltered: true)
    }
}
