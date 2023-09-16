//
//  ContentView.swift
//  bacscanner
//
//  Created by Victoria Kauffman on 9/16/23.
//

import SwiftUI


struct ContentView: View {
    @State private var showEstimateEyes = false
    @State private var showSoberPicAlert = false
    
    @State var name: String = UserDefaults.standard.string(forKey: "USER_NAME") ?? ""
    @State var inputName: String = ""
    
    @State var soberPicData = UserDefaults.standard.data(forKey: "SOBER_DATA") ?? nil
    @State var soberInput: UIImage? = nil

    var body: some View {
        Form {
            Section(header: Text("Name")) {
                TextField("Enter First Name", text: $inputName)
            }
            Section(header: Text("Sober Picture")) {
                Button("Take Sober Photo") {
                    showSoberPicAlert.toggle()
                }
                .alert(isPresented: $showSoberPicAlert) {
                    Alert(
                        title: Text("Are You Sober?"),
                        message: Text("For best results, you should take this photo completely sober. Are you sure you should continue?"),
                        primaryButton: .default(
                            Text("Continue"),
                            action: {
                                showEstimateEyes.toggle()
                            }
                        ),
                        secondaryButton: .destructive(
                            Text("Cancel"),
                            action: {}
                        )
                    )
                }
                .sheet(isPresented: $showEstimateEyes) {
                    CameraView().ignoresSafeArea()
                }
            }
            Section(header: Text("Actions:")) {
                Button("Save Data") {
                    // Save username
                    UserDefaults.standard.set(inputName, forKey: "USER_NAME")
                    name = inputName
                    print("Saved name: \(name)")
                    /*
                    // Save sober image
                    guard let data = soberInput.jpegData(compressionQuality: 0.5) else { return }
                        let encoded = try! PropertyListEncoder().encode(data)
                        UserDefaults.standard.set(encoded, forKey: "KEY")
                    
                
                     */
                }
            }
            Section(header: Text("Saved Data:")) {
                Text(name)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
