//
//  EventListView.swift
//  SportEvents
//
//  Created by Lukeš Andrej on 07/01/2022.
//

import SwiftUI

struct EventListView: View {
    @ObservedObject var viewModel = EventListViewModel()
    
    var body: some View {
        NavigationView{
            
            List(viewModel.events, id: \.self) { event in
                EventListRow(event: event)
            }
            Spacer()
        }
        .onAppear(perform: viewModel.loadEvents)
        .navigationTitle("Events")
        .navigationBarItems(trailing: NavigationLink(destination: AddEventView(), label: {
            Image(systemName: "plus")
        }))
    }
}


struct EventListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            EventListView(viewModel: EventListViewModel())
        }
    }
}

