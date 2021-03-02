//
//  TaskRepository.swift
//  First Test App
//
//  Created by Cristian Torres on 2/26/21.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

class TaskRepository: ObservableObject {
    
    let db = Firestore.firestore()
    
    @Published var tasks = [Task]()
    
    init() {
        loadData()
    }
    
    func loadData() {
        
        let userID = Auth.auth().currentUser?.uid
        
        db.collection("tasks")
            .order(by: "createdTime")
            .whereField("userID", isEqualTo: userID)
            .addSnapshotListener() { (querySnapshot, error) in
            if let querySnapshot = querySnapshot {
                self.tasks = querySnapshot.documents.compactMap { document in
                    do {
                        let newTask = try document.data(as: Task.self)
                        return newTask
                    } catch {
                        print(error)
                    }
                    return nil
                }
            }
        }
    }
    
    func addTask(_ task: Task) {
        do {
            var addedTask = task
            addedTask.userID = Auth.auth().currentUser?.uid
            let _ = try db.collection("tasks").addDocument(from: addedTask)
        } catch {
            fatalError("Unable to encode task: \(error.localizedDescription)")
        }
    }
    
    func updateTask(_ task: Task) {
        if let taskID = task.id {
            do {
                try db.collection("tasks").document(taskID).setData(from: task)
            } catch {
                fatalError("Unable to encode task: \(error.localizedDescription)")
            }
        }
    }
    
    func deleteTask(_ task: Task) {
        if let taskID = task.id {
            do {
                db.collection("tasks").document(taskID).delete()
            }
        }
    }
    
}
