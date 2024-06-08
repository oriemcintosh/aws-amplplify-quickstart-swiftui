//
//  AwsAmplifyAppApp.swift
//  AwsAmplifyApp
//
//  Created by Orie McIntosh on 6/7/24.
//

import Amplify
import Authenticator
import AWSCognitoAuthPlugin
import SwiftUI

@main
struct AwsAmplifyAppApp: App {
    init() {
        do {
            try Amplify.add(plugin: AWSCognitoAuthPlugin())
            try Amplify.configure(with: .amplifyOutputs)
        } catch {
            print("Unable to configure Amplify \(error)")
        }
    }
    
        var body: some Scene {
            WindowGroup {
                ContentView()
        }
    }
}
    
