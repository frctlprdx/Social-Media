//
//  Social_MediaApp.swift
//  Social Media
//
//  Created by Ivan on 02/09/24.
//

import SwiftUI
import Firebase
import FirebaseCore


@main
struct Social_MediaApp: App {
    init(){
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
