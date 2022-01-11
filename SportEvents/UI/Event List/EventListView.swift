//
//  EventListView.swift
//  SportEvents
//
//  Created by Lukeš Andrej on 07/01/2022.
//

import SwiftUI

enum StorageType: Int, CaseIterable, Equatable {
    case remote
    case local
    case all
    
    static let addOptions = [remote, local]
    
    var localized: String {
        switch self {
        case .remote: return "Remote"
        case .local: return "Local"
        case .all: return "All"
        }
    }
}

struct EventListView: View {
    
    @State private var selectedStorageType: StorageType = .remote
    @State private var presentAddEventSheet = false
    @StateObject var viewModel = EventListViewModel()
    
    var body: some View {
        NavigationView{
            VStack {
                Picker("Select data source please", selection: $selectedStorageType.onChange(storageTypeChanged)) {
                    ForEach(StorageType.allCases, id: \.self) {
                        Text($0.localized)
                    }
                }
                .pickerStyle(.segmented)
                .padding()
                List {
                    ForEach(viewModel.events) { event in
                        EventListRow(event: event)
                            .listRowBackground(event.color)
                    }
                    .onDelete { indexSet in
                        viewModel.delete(at: indexSet)
                    }
                }
                Spacer()
            }
            .navigationTitle("Events")
            .navigationBarItems(trailing: AddButton() {
                self.presentAddEventSheet.toggle()
            })
            .sheet(isPresented: self.$presentAddEventSheet) {
                AddEventView()
            }
        }
    }
    
    private func storageTypeChanged(to value: StorageType) {
        print("Storage type changed to \(value)")
        viewModel.prepareSelectedSubscriber(type: value)
        viewModel.loadData(type: value)
    }
}

struct EventListView_Previews: PreviewProvider {
    static var previews: some View {
        EventListView()
    }
}

