//
//  ToDoListPresenter.swift
//  SwUIDemo
//
//  Created by Azu on 17/07/2021.
//

import Foundation

protocol ListPresenterDelegate {
    var listData: [ToDoItem] { get }
    func deleteItem(at offsets: IndexSet)
    func moveItem(from source: IndexSet, destination: Int)
}

class ListPresenter: ObservableObject, ListPresenterDelegate {
    @Published var listData: [ToDoItem]
    
    init(_ data: [ToDoItem] = [
        ToDoItem(task: "Water Garden", imageName: "leaf"),
        ToDoItem(task: "Wash the car", imageName: "bolt.car"),
        ToDoItem(task: "Clean Staircase", imageName: "square.stack.3d.up"),
        ToDoItem(task: "Drink Water", imageName: "drop"),
        ToDoItem(task: "Cook Dinner", imageName: "bolt.horizontal")
    ]) {
        self.listData = data
    }
    
    func deleteItem(at offsets: IndexSet) {
        listData.remove(atOffsets: offsets)
    }
    
    func moveItem(from source: IndexSet, destination: Int) {
        // Move items
        listData.move(fromOffsets: source, toOffset: destination)
    }
}
