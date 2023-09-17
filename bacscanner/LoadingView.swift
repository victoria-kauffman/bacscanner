//
//  ContentView.swift
//  bacscanner
//
//  Created by Victoria Kauffman on 9/16/23.
//

import SwiftUI


struct LoadingView: View {
    @State private var showTakePhoto2 = false
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            VStack {
                Text("Eyealyze").foregroundColor(.white)
                    .bold()
                    .font(.custom(
                        "Genera Grotesk Heavy",
                        fixedSize: 37))
                    .padding(.vertical, 20)
            }
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
