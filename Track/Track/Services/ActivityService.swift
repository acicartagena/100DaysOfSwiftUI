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
    var activityList: ActivityList { get }
}

class ActivityService: ActivityProvider {
    static let shared = ActivityService()
    private(set) var activityList: ActivityList

    let jsonEncoder = JSONEncoder()

    var activitiesSink: Cancellable? = nil
    var activityListSink: Cancellable? = nil

    private let userDefaults: UserDefaults

    deinit {
        activitiesSink?.cancel()
        activityListSink?.cancel()
    }

    private init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
        if let savedActivityList = userDefaults.object(forKey: "activities") as? Data {
            let jsonDecoder = JSONDecoder()
            do {
                let decoded = try jsonDecoder.decode([Activity].self, from: savedActivityList)
                activityList = ActivityList(activities: decoded)
            } catch let error {
                print("error decoding: \(error)")
                activityList = ActivityList()
            }
        } else {
            activityList = ActivityList()
        }

        activitiesSink = activityList.$activities.sink { [weak self] activities in
            self?.save(activities: activities)
        }
    }

    func save(activities: [Activity]) {
        do {
            let encoded = try self.jsonEncoder.encode(activities)
            userDefaults.set(encoded, forKey: "activities")
        } catch let error {
            print("error encoding: \(error)")
        }
    }

}
