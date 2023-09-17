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
    
    @State var name: String
    
    @State var soberPic: UIImage? = nil
    
    @State var returnToCamera = false

    
    var body: some View {
        NavigationView {
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)
                VStack {
                    HStack {
                        Button("X  ", action: {
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
                        .padding(.trailing, 15)
                        Text("Good evening, \n\(name)")
                            .bold()
                            .font(.custom(
                                "Genera Grotesk Heavy",
                                fixedSize: 37))
                            .padding(.bottom, 25)
                            .multilineTextAlignment(.leading)
                            .foregroundColor(.white)
                    }
                    .navigationBarHidden(true)
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
                                Photo2View(showTakePhoto2: $showTakePhoto2, showDrunkView: $showDrunkView).ignoresSafeArea()
                            }
                            .popover(isPresented: $showDrunkView) {
                                       Text("You fucking drunkard")
                                           .font(.headline)
                                           .padding()
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
