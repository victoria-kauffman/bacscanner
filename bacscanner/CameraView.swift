//
//  CameraView.swift
//  bacscanner
//
//  Created by Victoria Kauffman on 9/16/23.
//

import SwiftUI

struct CameraView: UIViewControllerRepresentable {
    typealias UIViewControllerType = CameraController
    
    func makeUIViewController(context: Context) -> CameraController {
        let vc = CameraController()
        return vc
    }
    
    func updateUIViewController(_ uiViewController: CameraController, context: Context) {
        
    }
}
