//
//  AddActivityView.swift
//  Track
//
//  Created by Angela Cartagena on 27/6/20.
//  Copyright © 2020 ACartagena. All rights reserved.
//

import SwiftUI

struct AddActivityView: View {

    private let activityList: ActivityList = ActivityService.shared.activityList

    @State private var activityName: String = ""
    @State private var showError: Bool = false
    @State private var errorMessage: String = ""

    @Binding var isPresented: Bool

    var body: some View {
        let binding = Binding<String>(
            get: {
                self.activityName
            }, set: {
                self.activityName = $0
                self.textFieldChanged($0)
            }
        )
        return NavigationView {
            VStack {
                Text("What activity do you want tracked?")
                    .font(.largeTitle)
                    .padding()

                TextField("Go to sleep on time", text: binding, onEditingChanged: { _ in
                    self.showError = false
                    self.errorMessage = ""
                }) {
                    self.save()
                }
                .showsError(with: showError ? errorMessage : nil)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()


                Button(action: {
                    self.save()
                }) {
                    Text("Save")
                    .roundedGradient()
                }
                Spacer()
            }
            .navigationBarItems(trailing: Button("Cancel") {
                self.dismiss()
            })

        }

    }

    func save() {
        let activityNameLowercased = activityName.lowercased()
        guard activityName != "" else {
            showError = true
            errorMessage = "Activity can't be blank"
            return
        }

        guard !activityList.activities.contains(where: { $0.name.lowercased() == activityNameLowercased }) else {
            showError = true
            errorMessage = "Activity already exists"
            return
        }

        print("save: \(self.activityName)")
        let activity = Activity(name: activityName)
        activityList.add(activity: activity)
        dismiss()
    }

    func dismiss() {
        isPresented = false
    }

    func textFieldChanged(_ text: String) {
        self.showError = false
        self.errorMessage = ""
    }
}

struct AddActivityView_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
