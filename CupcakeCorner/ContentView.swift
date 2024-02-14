//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Насрулло Исмоилжонов on 14/02/24.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        AsyncImage(url: URL(string: "https://hws.dev/img/logo.png")) { phase in
            if let image = phase.image {
                image
                    .resizable()
                    .scaledToFit()
            } else if phase.error != nil {
                Text("There was an error loading an image")
            } else {
                ProgressView()
            }
        }
        
    }
}

#Preview {
    ContentView()
}
