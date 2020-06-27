//
//  ActivityService.swift
//  Track
//
//  Created by Angela Cartagena on 27/6/20.
//  Copyright © 2020 ACartagena. All rights reserved.
//

import Foundation
import Combine

protocol ActivityProvider {
    var activities: [Activity] { get }
    func add(activity: Activity)
}

class ActivityService: ActivityProvider, ObservableObject {
    static let shared = ActivityService()
    @Published private(set) var activities: [Activity]

    let jsonEncoder = JSONEncoder()

    var activitiesSink: Cancellable? = nil

    private let userDefaults: UserDefaults

    var cancellables: [AnyCancellable] = []

    deinit {
        activitiesSink?.cancel()
        for cancellable in cancellables {
            cancellable.cancel()
        }
    }

    private init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults

        if let savedActivityList = userDefaults.object(forKey: "activities") as? Data {
            let jsonDecoder = JSONDecoder()
            do {
                let decoded = try jsonDecoder.decode([Activity].self, from: savedActivityList)
                activities = decoded
                decoded.forEach { [weak self] activity in
                    let cancellable = activity.$count.sink { [weak self] count in
                        self?.update(activity: Activity(name: activity.name, count: count))
                    }
                    self?.cancellables.append(cancellable)
                }
            } catch let error {
                print("error decoding: \(error)")
                activities = []
            }
        } else {
            activities = []
        }

        activitiesSink = $activities.sink { [weak self] activities in
            self?.save(activities: activities)
        }
    }

    func add(activity: Activity) {
        let cancellable = activity.$count.sink { [weak self] count in
            self?.update(activity: Activity(name: activity.name, count: count))
        }
        cancellables.append(cancellable)
        activities.append(activity)
    }

    func update(activity: Activity) {
        print("activity: \(activity.name) count changed: \(activity.count)")
        guard let index = activities.firstIndex(where: { $0.name == activity.name }) else { return }

        var temp = activities
        temp[index] = activity
        save(activities: temp)
    }

    private func save(activities: [Activity]) {
        do {
            let encoded = try self.jsonEncoder.encode(activities)
            userDefaults.set(encoded, forKey: "activities")
            print(activities)
        } catch let error {
            print("error encoding: \(error)")
        }
    }

}
