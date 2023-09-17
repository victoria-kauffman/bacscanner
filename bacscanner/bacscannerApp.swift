//
//  bacscannerApp.swift
//  bacscanner
//
//  Created by Victoria Kauffman on 9/16/23.
//

import SwiftUI

@main
struct bacscannerApp: App {
    var body: some Scene {
        WindowGroup {
            if (!checkPrevData()) {
                CameraView()
            } else {
                HomeView(name: "")
            }
        }
    }
    
    func checkPrevData() -> Bool {
        if UserDefaults.standard.string(forKey: "USER_NAME") == nil {
            return false
        }
        
        
        let documentDirectory = FileManager.SearchPathDirectory.documentDirectory

            let userDomainMask = FileManager.SearchPathDomainMask.userDomainMask
            let paths = NSSearchPathForDirectoriesInDomains(documentDirectory, userDomainMask, true)

            if let dirPath = paths.first {
                let imageUrl = URL(fileURLWithPath: dirPath).appendingPathComponent("photo1.png")
                let image = UIImage(contentsOfFile: imageUrl.path)
                return image != nil
            } else {
                return false
            }
    }
}
