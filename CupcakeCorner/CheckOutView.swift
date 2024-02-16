//
//  CheckOutView.swift
//  CupcakeCorner
//
//  Created by Насрулло Исмоилжонов on 16/02/24.
//

import SwiftUI

struct CheckOutView: View {
    var order: Order
    
    var body: some View {
        ScrollView {
            VStack{
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 233)
                
                Text("Your total cost is: \(order.cost, format: .currency(code: "USD"))")
                    .font(.title)
                
                Button("Place Order", action: {})
                    .padding()
            }
        }
        .navigationTitle("Check out")
        .navigationBarTitleDisplayMode(.inline)
        .scrollBounceBehavior(.basedOnSize)
    }
}

#Preview {
    CheckOutView(order: Order())
}
