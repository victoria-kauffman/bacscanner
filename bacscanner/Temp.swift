//
//  ContentView.swift
//  bacscanner
//
//  Created by Victoria Kauffman on 9/16/23.
//

import SwiftUI


struct Temp: View {
    @State private var showEstimateEyes = false
    @State private var bac = false
    @State private var showSoberPicAlert = false
    @State var name: String = UserDefaults.standard.string(forKey: "USER_NAME") ?? ""
    @State var inputText: String = ""
    private var displayedBac: String {
        return "You shouldn't be on the road, you fucking drunkard"
    }

    var body: some View {
        Grid(alignment: .bottom, horizontalSpacing: 10, verticalSpacing: 10) {
                GridRow {
                    Text("Tips")
                        .bold()
                        .background(.cyan)
                    Button("Estimate BAC") {
                        showEstimateEyes.toggle()
                    }
                    .background(.pink)
                    .sheet(isPresented: $showEstimateEyes) {
                        CameraView().ignoresSafeArea()
                    }
                }
                GridRow {
                    Text(displayedBac).bold()
                        .background(.orange)
                    Text("Chatbot").bold()
                        .background(.red)
                }
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
                .bold()
                .background(.yellow)
                .sheet(isPresented: $showEstimateEyes) {
                    CameraView().ignoresSafeArea()
                }
        }
    }
}

/*
let dialogMessage = "For best results, you should take this photo completely sober. Are you sure you should continue?"
let alert = UIAlertController(title: "Alert", message: "Message", preferredStyle: .alert)
alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
    switch action.style{
        case .default:
        print("default")
        
        case .cancel:
        print("cancel")
        
        case .destructive:
        print("destructive")
        
    }
}))
self.present(alert, animated: true, completion: nil)
 */

/*.sheet(isPresented: $showEstimateEyes) {
    Form {
        Section("Settings") {
            Toggle("Drunk?", isOn: $bac)
        }
        Button("Done") {
            showEstimateEyes.toggle()
        }
        Section("Preview") {
            Text("Meep")
        }
    }
} */

struct Temp_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
