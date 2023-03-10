//
//  eatJNUApp.swift
//  eatJNU
//
//  Created by 정나영 on 2023/02/07.
//

import SwiftUI

@main
struct eatJNUApp: App {
    var body: some Scene {
        //let urlImageService = URLImageService(fileStore: nil, inMemoryStore: URLImageInMemoryStore())

        WindowGroup {
            NavigationView {
               MainView()
//                    .environment(\.urlImageService, urlImageService)
            }
            
        }
    }
}
