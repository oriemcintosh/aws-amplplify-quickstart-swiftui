//
//  ContentView.swift
//  AwsAmplifyApp
//
//  Created by Orie McIntosh on 6/7/24.
//

import SwiftUI
import Amplify
import Authenticator


struct ContentView: View {
    
    // Create an observalbe object instance.
    @StateObject var vm = TodoViewModel()
    
    var body: some View {
        Authenticator { state in
            VStack {
                Button("Sign out") {
                    Task {
                        await state.signOut()
                    }
                }
                List {
                    ForEach($vm.todos, id: \.id) { todo in
                        TodoRow(vm: vm, todo: todo)
                    }.onDelete { IndexSet in
                        vm.deleteTodos(indexSet: <#T##IndexSet#>)
                        vm.listTodos()
                    }
                }
                Button(action: {
                    vm.createTodo()
                    vm.listTodos()
                }) {
                    HStack {
                        Text("Add a New Todo")
                        Image(systemName: "plus")
                    }
                }
                .accessibilityLabel("New Todo")
            }
        }
    }
}
