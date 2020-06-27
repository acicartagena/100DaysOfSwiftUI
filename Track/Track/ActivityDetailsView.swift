//
//  ActivityDetailsView.swift
//  Track
//
//  Created by Angela Cartagena on 27/6/20.
//  Copyright © 2020 ACartagena. All rights reserved.
//

import SwiftUI

struct ActivityDetailsView: View {

    @ObservedObject var activity: Activity

    var body: some View {
        VStack {
            Text(activity.name)
                .font(.title)
                .padding()
            VStack {
                Text("\(activity.count)")
                    .font(.largeTitle)
                Text("times")
                    .font(.callout)
            }
            .padding()
            Spacer()
            Button(action: {
                self.increaseCount()
            }) {
                Text("Add")
                    .roundedGradient(start: .red, end: .orange)
            }
        }
    }

    func increaseCount() {
        activity.update(count: activity.count + 1)
    }
}


