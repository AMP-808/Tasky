//
//  Task.swift
//  First Test App
//
//  Created by Cristian Torres on 2/26/21.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Task: Codable ,Identifiable {
    @DocumentID var id: String?
    var title: String
    var completed: Bool
    @ServerTimestamp var createdTime: Timestamp?
    var userID: String?
}

#if DEBUG

let testDataTasks = [
    Task(title: "Impliment the UI", completed: true),
    Task(title: "Connect to Firebase", completed: false),
    Task(title: "?????", completed: false),
    Task(title: "Profit!!!", completed: false),
]

#endif
