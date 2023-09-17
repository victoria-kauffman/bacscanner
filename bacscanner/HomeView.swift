//
//  ContentView.swift
//  bacscanner
//
//  Created by Victoria Kauffman on 9/16/23.
//

import SwiftUI


struct HomeView: View {
    @State private var showTakePhoto2 = false
    
    @State var name: String
    
    @State var soberPic: UIImage? = nil

    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            VStack {
                Text("Good evening, \n\(name)")
                    .bold()
                    .font(.custom(
                        "Genera Grotesk Heavy",
                        fixedSize: 37))
                    .padding(.bottom, 25)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.white)
                
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
                            Photo2View().ignoresSafeArea()
                        }
                        }
            }
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
    }
}

/*
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
*/
