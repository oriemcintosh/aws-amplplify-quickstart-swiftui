//
//  TodoViewModel.swift
//  AwsAmplifyApp
//
//  Created by Orie McIntosh on 6/8/24.
//

import Foundation
import Amplify

@MainActor
class TodoViewModel: ObservableObject {
    @Published var todos: [Todo] = []
    func createTodo() {
        //        let creationTime = Temporal.DateTime.now()
        //        let todo = Todo(
        //            content: "Random Todo \(creationTime)",
        //            isDone: false,
        //            createdAt: creationTime,
        //            updatedAt: creationTime
        //        )
    }
    func listTodos() {
        let request = GraphQLRequest<Todo>.list(Todo.self)
        Task {
            do {
                let result = try await Amplify.API.query(request: request)
                switch result {
                case .success(let todos):
                    print("Successfully retrieved list of todos: \(todos)")
                    self.todos = todos.elements
                case .failure(let error):
                    print("Got failed result with \(error.errorDescription)")
                }
            } catch let error as APIError {
                print("Failed to query list of todos: ", error)
            } catch {
                print("Unexpected error: \(error)")
            }
        }
    }
    func deleteTodos(indexSet: IndexSet) {
        for index in indexSet {
            let todo = todos[index]
            Task {
                do {
                    let result = try await Amplify.API.mutate(request: .delete(todo))
                    switch result {
                    case .success(let todo):
                        print("Deleted that todo: \(todo)")
                    case .failure(let error):
                        print("Got failed result with \(error.errorDescription)")
                    }
                } catch let error as APIError {
                    print("Failed to delete todo: ", error)
                } catch {
                    print("Unexpected error: \(error)")
                }
            }
        }
    }
    func updateTodo(todo: Todo) {
        Task {
            do {
                let result = try await Amplify.API.mutate(request: .update(todo))
                switch result {
                case .success(let todo):
                    print("Successfully updated todo: \(todo)")
                case .failure(let error):
                    print("Got failed result with \(error.errorDescription)")
                }
            } catch let error as APIError {
                print("Failed to updated todo: ", error)
            } catch {
                print("Unexpected error: \(error)")
            }
        }
    }
}
