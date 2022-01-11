//
//  AddEventView.swift
//  SportEvents
//
//  Created by Lukeš Andrej on 07/01/2022.
//

import SwiftUI

struct AddEventView: View {
    
    @State private var isErrorAlertShown = false
    @Environment(\.presentationMode) private var presentationMode
    @StateObject var viewModel: AddEventViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section {
                        TextField("Name", text: $viewModel.event.name)
                        TextField("Address", text: $viewModel.event.address)
                        TextField("Duration (hours)",
                                  value: $viewModel.event.duration,
                                  formatter: NumberFormatter())
                        Picker("", selection: $viewModel.selectedStorageType) {
                            ForEach(StorageType.addOptions, id: \.self) {
                                Text($0.localized).tag($0.rawValue)
                            }
                        }
                        .onChange(of: viewModel.selectedStorageType) { _ in
                            viewModel.changeEventType()
                        }
                        .pickerStyle(.segmented)
                        .padding()
                    }
                }
            }
            .navigationBarTitle("New event", displayMode: .inline)
            .navigationBarItems(
                leading:
                    Button(action: { self.cancelTapped() }) {
                        Text("Cancel")
                    },
                trailing:
                    Button(action: { self.saveTapped() }) {
                        Text("Save")
                    }
                    .disabled(!viewModel.modified)
            )
            .alert(isPresented: self.$isErrorAlertShown, content: {
                Alert(title: Text("An error occured!"),
                      message: Text("Something went wrong during adding of new item"),
                      dismissButton: .default(Text("OK")))
            })
        }
    }
    
    /// Click on the navigation item in the navigation bar
    private func cancelTapped() {
        dismiss()
    }
    
    /// Click on the navigation item in the navigation bar
    private func saveTapped() {
        self.viewModel.addNewEvent(successCallback: {
            dismiss()
        }, errorCallback: { message in
            isErrorAlertShown.toggle()
        })
    }
    
    /// Helper for dismissing of current screen
    private func dismiss() {
        self.presentationMode.wrappedValue.dismiss()
    }
}

struct AddEventView_Previews: PreviewProvider {
    static var previews: some View {
        AddEventView(viewModel: AddEventViewModel(remoteRepo: FirebaseEventRepository(), localRepo: LocalSportEventRepository()))
    }
}
