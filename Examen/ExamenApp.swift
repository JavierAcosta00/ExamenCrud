//
//  ExamenApp.swift
//  Examen
//
//  Created by CCDM28 on 17/11/22.
//

import SwiftUI

@main
struct ExamenApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(coreDM:CoreDataManager())
        }
    }
}
