//
//  ContentView.swift
//  AwsAmplifyApp
//
//  Created by Orie McIntosh on 6/7/24.
//

import Amplify
import Authenticator

struct ContentView: View {
    var body: some View {
        Authenticator { state in
            VStack {
                Button("Sign out") {
                    Task {
                        await state.signOut()
                    }
                }
            }
        }
    }
}
