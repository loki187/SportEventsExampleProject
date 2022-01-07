//
//  AddEventView.swift
//  SportEvents
//
//  Created by Lukeš Andrej on 07/01/2022.
//

import SwiftUI

struct AddEventView: View {
    
    private var viewModel = AddEventViewModel()
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text("Name of the event:")
                Text("Address:")
                Spacer()
            }
            Button("Create event") {
                viewModel.saveNewEvent()
            }.buttonStyle(SendButton())
        }
        
        .navigationTitle("Add Event")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AddEventView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AddEventView()
        }
    }
}
