//
//  ContentView.swift
//  SwiftCamera
//
//  Created by Rolando Rodriguez on 10/15/20.
//

import SwiftUI
import Combine
import AVFoundation

struct Photo2View: View {
    @StateObject var model = CameraModel()
    
    @State var currentZoomFactor: CGFloat = 1.0
    
    @State var dataSaved = false
    
    @State var inputName: String = ""
    
    @State var soberInput: UIImage? = nil
    
    @State var modelConfigured = false
    
    @Binding var showTakePhoto2: Bool
    
    @Binding var showDrunkView: Bool

    
    var captureButton: some View {
        Button(action: {
            model.capturePhoto()
        }, label: {
            Circle()
                .foregroundColor(.white)
                .frame(width: 80, height: 80, alignment: .center)
                .overlay(
                    Circle()
                        .stroke(Color.black.opacity(0.8), lineWidth: 2)
                        .frame(width: 65, height: 65, alignment: .center)
                )
        })
    }
    
    var flipCameraButton: some View {
        Button(action: {
            model.flipCamera()
        }, label: {
            Circle()
                .opacity(0)
                .frame(width: 60, height: 60, alignment: .center)
                .overlay(
                    Image(systemName: "camera.rotate.fill")
                        .resizable()
                        .frame(width: 25.0, height: 25.0)
                        .foregroundColor(.white)
                        )
                .padding(.horizontal, 10)
        })
    }
    
    var body: some View {
        NavigationView {
            GeometryReader { reader in
                ZStack {
                    Color.black.edgesIgnoringSafeArea(.all)
                    VStack {
                        Text("BACScanner").foregroundColor(.white)
                            .bold()
                            .font(.custom(
                                "Genera Grotesk Heavy",
                                fixedSize: 37))
                            .padding(.vertical, 20)
                       
                        if (model.photo == nil)  {
                            CameraPreview(session: model.session)
                                .gesture(
                                    DragGesture().onChanged({ (val) in
                                        //  Only accept vertical drag
                                        if abs(val.translation.height) > abs(val.translation.width) {
                                            //  Get the percentage of vertical screen space covered by drag
                                            let percentage: CGFloat = -(val.translation.height / reader.size.height)
                                            //  Calculate new zoom factor
                                            let calc = currentZoomFactor + percentage
                                            //  Limit zoom factor to a maximum of 5x and a minimum of 1x
                                            let zoomFactor: CGFloat = min(max(calc, 1), 5)
                                            //  Store the newly calculated zoom factor
                                            currentZoomFactor = zoomFactor
                                            //  Sets the zoom factor to the capture device session
                                            model.zoom(with: zoomFactor)
                                        }
                                    })
                                )
                                .onAppear {
                                    if !modelConfigured {
                                        model.configure()
                                        modelConfigured = true
                                    }
                                }
                                .alert(isPresented: $model.showAlertError, content: {
                                    Alert(title: Text(model.alertError.title), message: Text(model.alertError.message), dismissButton: .default(Text(model.alertError.primaryButtonTitle), action: {
                                        model.alertError.primaryAction?()
                                    }))
                                })
                                .overlay(
                                    Group {
                                        if model.willCapturePhoto {
                                            Color.black
                                        }
                                        
                                    }
                                )
                                .animation(.easeInOut)
                                .frame(width: 370, height: 460)
                                .cornerRadius(15)
                            
                            ZStack {
                                HStack {
                                    Button(action: {
                                        model.switchFlash()
                                    }, label: {
                                        Image(systemName: model.isFlashOn ? "bolt.fill" : "bolt.slash.fill")
                                            .font(.system(size: 20, weight: .medium, design: .default))
                                    })
                                    .accentColor(model.isFlashOn ? .yellow : .white)
                                    Spacer()
                                }
                                .padding(.horizontal, 40)
                                HStack {
                                    captureButton
                                        .frame( alignment: .center)
                                }
                                HStack {
                                    Spacer()
                                    flipCameraButton
                                }
                                .padding(.horizontal, 20)
                            }
                            .padding(.vertical, 10)
                        } else {
                            Image(uiImage: model.photo.image!)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .padding(.bottom, 35)
                                .cornerRadius(15)
                            
                                .overlay(
                                    HStack {
                                        Button(action: {
                                            model.deletePhoto()
                                            model.photo = nil
                                        }, label: {
                                            Text("Discard")
                                                .bold()
                                                .font(.custom(
                                                    "Genera Grotesk Heavy",
                                                    fixedSize: 20))
                                                .foregroundColor(.white)
                                        })
                                        Spacer()
                                        Button(action: {
                                            // let URL =
                                            
                                            
                                            showTakePhoto2 = false
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                                  showDrunkView = true
                                                }
                                        }, label: {
                                            Text("Continue")
                                                .bold()
                                                .font(.custom(
                                                    "Genera Grotesk Heavy",
                                                    fixedSize: 20))
                                                .foregroundColor(.white)
                                        })
                                        
                                    }.ignoresSafeArea(.keyboard)
                                        .padding(.horizontal, 45)
                                        .padding(.top, 300)
                                    
                                )
                            
                        }
                    }
                }

            }
            .ignoresSafeArea(.keyboard)
            
        }
    }

}

struct Photo2View_Previews: PreviewProvider {
    static var previews: some View {
        CameraView()
    }
}
