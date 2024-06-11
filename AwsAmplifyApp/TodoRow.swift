//
//  TodoRow.swift
//  AwsAmplifyApp
//
//  Created by Orie McIntosh on 6/8/24.
//

import Foundation
import SwiftUI
import Amplify

struct TodoRow: View {
    @ObservedObject var vm: TodoViewModel
    @Binding var todo: Todo

    var body: some View {
        Toggle(isOn: $todo.isDone) {
            Text(todo.content ?? "")
        }
        .toggleStyle(SwitchToggleStyle())
        .onChange(of: todo.isDone) { _, newValue in
            var updatedTodo = todo
            updatedTodo.isDone = newValue
            vm.updateTodo(todo: updatedTodo)
            vm.listTodos()
        }
    }
}
