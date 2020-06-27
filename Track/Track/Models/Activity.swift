//  Copyright © 2020 ACartagena. All rights reserved.

import Foundation
import Combine

class Activity: Codable, Identifiable, ObservableObject {
    var id: String { return name }
    
    let name: String
    @Published var count: Int = 0

    enum CodingKeys: CodingKey {
        case name
        case count
    }



    init(name: String, count: Int = 0) {
        self.name = name
        self.count = count
    }

    public func update(count: Int) {
        self.count = count
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        name = try container.decode(String.self, forKey: .name)
        count = try container.decode(Int.self, forKey: .count)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(name, forKey: .name)
        try container.encode(count, forKey: .count)
    }
}


class ActivityList: ObservableObject {
    @Published private(set) var activities: [Activity]
    var cancellables: [AnyCancellable] = []

    init(activities: [Activity] = []) {
        self.activities = activities

        self.activities.forEach { [weak self] activity in
            let cancellable = activity.$count.sink { [weak self] count in
                print("activity: \(activity) count changed: \(count)")
            }
            self?.cancellables.append(cancellable)
        }
    }

    func add(activity: Activity) {
        let cancellable = activity.$count.sink { [weak self] count in
            print("activity: \(activity) count changed: \(count)")
        }
        cancellables.append(cancellable)
        activities.append(activity)
    }

}
