//
//  TestNewTextFocusApp.swift
//  TestNewTextFocus
//
//  Created by David Siebecker on 11/28/21.
//

import SwiftUI

@main
struct TestNewTextFocusApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                ContentViewEnvironmentObject()
                    .tabItem {
                        Text("EnvObj")
                    }
                ContentViewEnvironment()
                    .tabItem {
                        Text("Env")
                    }
                ContentViewVariablePassing()
                    .tabItem {
                        Text("VarPass")
                    }
                ContentViewBindingEnvironmentObject()
                    .tabItem {
                        Text("BindEnvObj")
                    }
                ContentViewBindingEnvironment()
                    .tabItem {
                        Text("BindEnv")
                    }
            }
        }
    }
}
