//
//  CameraController.swift
//  bacscanner
//
//  Created by Victoria Kauffman on 9/16/23.
//

import UIKit

class CameraController: UIViewController {
    
    @IBAction func camera(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraView = UIImagePickerController()
            cameraView.delegate = self as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
            cameraView.sourceType = .camera
            self.present(cameraView, animated: true, completion: nil)
            print("YAY")
        } else {
            print("SHIT")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
