//  Copyright © 2020 ACartagena. All rights reserved.

import Foundation

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
