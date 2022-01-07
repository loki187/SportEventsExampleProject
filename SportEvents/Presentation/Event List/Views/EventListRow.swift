//
//  EventListRow.swift
//  SportEvents
//
//  Created by Lukeš Andrej on 07/01/2022.
//

import SwiftUI

struct EventListRow: View {
    
    var event: SportEvent
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(event.name)")
                .font(.title)
                .fontWeight(.bold)
                
            Text("\(event.address)")
            Text("Duration: \(event.duration)")
            Spacer()
        }
    }
}

struct EventListROw_Previews: PreviewProvider {
    static var previews: some View {
        EventListRow(event:
        SportEvent(name: "Name", address: "Address", duration: 5))
        
    }
}
