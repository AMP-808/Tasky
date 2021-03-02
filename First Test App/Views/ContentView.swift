//
//  ContentView.swift
//  First Test App
//
//  Created by Cristian Torres on 2/21/21.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var taskListVM = TaskListViewModel()
    let tasks = testDataTasks
    
    @State var presentAddNewItem = false
    @State var showSignInForm = false
    
    private func removeTask(at offsets: IndexSet) {
        offsets.sorted(by: > ).forEach { (i) in
            let task = self.taskListVM.taskCellViewModels[i].task
            TaskRepository().deleteTask(task)
        }
    }
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                List {
                    ForEach(taskListVM.taskCellViewModels) { taskCellVM in
                        TaskCell(taskCellVM: taskCellVM)
                    }
                    .onDelete(perform: removeTask)
                    if presentAddNewItem {
                        TaskCell(taskCellVM: TaskCellViewModel(task: Task(title: "", completed: false))) { task in
                            self.taskListVM.addTask(task: task)
                            self.presentAddNewItem.toggle()
                        }
                    }
                }
                Button(action: { self.presentAddNewItem.toggle() }) {
                    HStack {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .frame(width: 20, height: 20)
                        Text("Add New Task")
                    }
                }
                .padding()
            }
            .sheet(isPresented: $showSignInForm) {
                SignInView()
            }
            .navigationBarItems(trailing:
                Button(action: { self.showSignInForm.toggle() } ) {
                    Image(systemName: "person.circle")
                        .resizable()
                        .frame(width: 20, height: 20)
                }
            )
            .navigationTitle("Tasks")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct TaskCell: View {
    
    @ObservedObject var taskCellVM: TaskCellViewModel
    
    var onCommit: (Task) -> (Void) = { _ in }
    
    var body: some View {
        HStack {
            Image(systemName: taskCellVM.task.completed ? "checkmark.circle.fill" : "circle")
                .resizable()
                .frame(width: 20, height: 20)
                .onTapGesture {
                    self.taskCellVM.task.completed.toggle()
                }
            TextField("Enter The Task Title", text: $taskCellVM.task.title, onCommit: {
                self.onCommit(self.taskCellVM.task)
            })
        }
    }
    
//    func delete(at offsets: IndexSet) {
//        TaskRepository.deleteTask()
//    }
    
}
