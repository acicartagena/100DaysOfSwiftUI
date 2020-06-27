//  Copyright © 2020 ACartagena. All rights reserved.

import SwiftUI

class Activity: ObservableObject {
    let name: String
    @Published var numberOfTimes: Int = 0

    init(name: String) {
        self.name = name
    }
}

class ActivityList: ObservableObject {
    @Published var acitivities: [Activity] = []
}

struct ContentView: View {
    var body: some View {
        Text("Hello, World!")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
