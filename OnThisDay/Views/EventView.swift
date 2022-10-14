// Project: OnThisDay
//
//  
//

import SwiftUI

struct EventView: View {
    
    var event: Event
    
    var body: some View {

        VStack {
            VStack(alignment: .leading, spacing: 20) {
                    Text(event.year)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal, 0)
                        .padding(.vertical, 10)
                        .background(Color(.systemGray))

                Text(event.text)
                    .font(.title3)

                Divider()
                VStack(alignment: .leading, spacing: 10) {
                    Text("Related Links:")
                        .font(.title2)

                    ForEach(event.links) { link in
                        Link(link.title, destination: link.url)
                            .onHover { inside in
                                if inside {
                                    NSCursor.pointingHand.push()
                                } else {
                                    NSCursor.pop()
                                }
                            }
                    }
                }
                Spacer()
            }
            Spacer()
        }
        .padding(7)
        .background(Color(.systemGray).opacity(0.3))
        .frame(width: 250)
    }
}

struct EventView_Previews: PreviewProvider {
    static var previews: some View {
        EventView(event: Event.sampleEvent)
    }
}
