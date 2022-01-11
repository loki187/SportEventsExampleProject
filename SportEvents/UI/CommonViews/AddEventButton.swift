//
//  AddButton.swift
//  SportEvents
//
//  Created by Andrej Lukes on 09/01/2022.
//

import SwiftUI

struct AddButton: View {
    var action: () -> Void
    var body: some View {
        Button(action: { self.action() }) {
            Image(systemName: "plus")
        }
    }
}

struct AddEventButton_Previews: PreviewProvider {
    static var previews: some View {
        AddButton(action: {})
    }
}
