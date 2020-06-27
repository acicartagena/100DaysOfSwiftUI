//  Copyright © 2020 ACartagena. All rights reserved.

import SwiftUI

struct ContentView: View {

    @ObservedObject var activityList = ActivityService.shared.activityList
    @State private var showingAddActivity = false

    var body: some View {
        NavigationView {
            List {
                ForEach(activityList.activities, id: \.name) { activity in
                    NavigationLink(destination: ActivityDetailsView(activity: activity)) {
                        Text(activity.name)
                    }
                }
            }
            .navigationBarTitle("Track")
            .navigationBarItems(trailing:
                Button(action: {
                    self.showingAddActivity = true
                }) {
                    Image(systemName: "plus")
                }
            )
        }.sheet(isPresented: $showingAddActivity) {
            AddActivityView(isPresented: self.$showingAddActivity)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
