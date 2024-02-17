//
//  CheckOutView.swift
//  CupcakeCorner
//
//  Created by Насрулло Исмоилжонов on 16/02/24.
//

import SwiftUI

struct CheckOutView: View {
    var order: Order
    
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false
    @State private var errorMessage = ""
    @State private var showingError = false
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
                
                Button("Place Order"){
                    Task{
                        await placeOrder()
                    }
                }
                    .padding()
                    .alert("Error", isPresented: $showingError) {
                        
                    }message: {
                        Text(errorMessage)
                    }
            }
        }
        .navigationTitle("Check out")
        .navigationBarTitleDisplayMode(.inline)
        .scrollBounceBehavior(.basedOnSize)
        .alert("Thank you", isPresented: $showingConfirmation) {
        } message: {
            Text(confirmationMessage)
        }
    }
    
    func placeOrder() async {
        
        guard let encoded = try? JSONEncoder().encode(order) else {
            print("Failed to encode")
            return
        }
        
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.httpMethod = "POST"
        
        
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            do {
                let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
                confirmationMessage = "Your order for \(decodedOrder.quantity)x \(Order.types[decodedOrder.type].lowercased()) cupcakes is on its way!"
                showingConfirmation = true
            }catch {
                print("Check out failed: \(error.localizedDescription)")
            }
        } catch {
            errorMessage = "Error in checkout: \(error.localizedDescription)"
            showingError = true
        }
        
        
    }
}

#Preview {
    CheckOutView(order: Order())
}
