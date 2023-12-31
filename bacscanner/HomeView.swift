//
//  ContentView.swift
//  bacscanner
//
//  Created by Victoria Kauffman on 9/16/23.
//

import SwiftUI


struct HomeView: View {
    @State private var showTakePhoto2 = false
    
    @State private var showDrunkView = false
    
    @State private var drunkenness = false
    
    @State var name: String = ""
    
    @State var soberPic: UIImage? = nil
    
    @State var returnToCamera = false

    
    var body: some View {
        NavigationView {
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)
                VStack {
                    HStack {
                        Button("Clear", action: {
                            // Clear all data
                            UserDefaults.standard.removeObject(forKey: "USER_NAME")
                            
                            let documentDirectory = FileManager.SearchPathDirectory.documentDirectory
                            
                            let userDomainMask = FileManager.SearchPathDomainMask.userDomainMask
                            let paths = NSSearchPathForDirectoriesInDomains(documentDirectory, userDomainMask, true)
                            
                            if let dirPath = paths.first {
                                let imageUrl = URL(fileURLWithPath: dirPath).appendingPathComponent("photo1.png")
                                do {
                                    try FileManager.default.removeItem(atPath: imageUrl.absoluteString)
                                } catch { }
                            }
                            
                            // Go back to CameraView()
                            returnToCamera = true
                        })
                        .foregroundColor(.white)
                        .padding(.leading, -20)
                        
                        
                        Text("Good evening,\n\(name)")
                            .bold()
                            .font(.custom(
                                "Genera Grotesk Heavy",
                                fixedSize: 36))
                            .padding(.bottom, 25)
                            .padding(.top, 25)
                            .padding(.leading, 50)
                            .multilineTextAlignment(.leading)
                            .foregroundColor(.white)
                    }
                    .navigationBarHidden(false)
                    NavigationLink("", destination: CameraView(), isActive: $returnToCamera).hidden()
                    if (soberPic != nil ) {
                        Image(uiImage: soberPic!)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .blur(radius: 10)
                            .overlay(
                                
                                Button(action: {
                                    showTakePhoto2.toggle()
                                }) {
                                    Text("Take Photo 2")
                                        .foregroundColor(.black)
                                        .font(.system(size: 20))
                                }
                                    .frame(width: 175, height: 46)
                                    .background(.white)
                                    .cornerRadius(25)
                            )
                            .sheet(isPresented: $showTakePhoto2) {
                                Photo2View(showTakePhoto2: $showTakePhoto2, showDrunkView: $showDrunkView, drunkenness: $drunkenness).ignoresSafeArea()
                            }
                            .popover(isPresented: $showDrunkView) {
                                if drunkenness {
                                    Text("You're most definitely drunk")
                                        .font(.headline)
                                        .padding()
                                } else {
                                    Text("You don't seem intoxicated.")
                                        .font(.headline)
                                        .padding()
                                }
     
                                   }
                            .navigationBarHidden(true)
                    }
                }
                .navigationBarHidden(true)
            }.onAppear {
                name = UserDefaults.standard.string(forKey: "USER_NAME")!
                
                
                let documentDirectory = FileManager.SearchPathDirectory.documentDirectory
                
                let userDomainMask = FileManager.SearchPathDomainMask.userDomainMask
                let paths = NSSearchPathForDirectoriesInDomains(documentDirectory, userDomainMask, true)
                
                if let dirPath = paths.first {
                    let imageUrl = URL(fileURLWithPath: dirPath).appendingPathComponent("photo1.png")
                    let image = UIImage(contentsOfFile: imageUrl.path)
                    soberPic = image
                }
            }
            .navigationBarHidden(true)
        }
 .navigationBarHidden(true)

 }
}
