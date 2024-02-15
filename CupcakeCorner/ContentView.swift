//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Насрулло Исмоилжонов on 14/02/24.
//
import SwiftUI

@Observable
class User: Codable {
    var name = "Nasrullo"
    
    enum CodingKeys: String, CodingKey {
        case _name = "name"
    }
}

struct ContentView: View {
    
    var body: some View {
        
        Button("Encode Nasrullo", action: encodeNasrullo)
    }
    
    func encodeNasrullo() {
        let data = try! JSONEncoder().encode(User())
        let str = String(decoding: data, as: UTF8.self)
        print(str)
    }
}

#Preview {
    ContentView()
}
