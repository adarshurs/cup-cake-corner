//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Adarsh Urs on 23/03/21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var order = Order()
    
    @State private var username = ""
    @State private var email = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Select your cake type", selection: $order.type) {
                        ForEach(0..<Order.types.count) {
                            Text(Order.types[$0])
                        }
                    }

                    Stepper(value: $order.quantity, in: 3...20) {
                        Text("Number of cakes: \(order.quantity)")
                    }
                }
                
                Section {
                    Toggle(isOn: $order.specialRequestEnabled.animation()){
                            Text("Any special requests?")
                        }
                    
                    if order.specialRequestEnabled{
                        Toggle(isOn: $order.extraFrosting){
                            Text("Add extra frosting")
                        }
                        Toggle(isOn: $order.addSprinkles){
                            Text("Add extra sprinkles")
                        }
                    }
                }
                
                Section{
                    NavigationLink(
                        destination: AddressView(order: order)){
                         Text("Delivery Details")
                    }
                }
                
            }
            .navigationBarTitle("Cupcake Corner")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

class User: ObservableObject, Codable {
    @Published var name = "Adarsh Urs"
    
    enum CodingKeys: CodingKey {
        case name
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
    }
}

struct Response: Codable {
    var results: [Result]
}

struct Result: Codable {
    var trackId: Int
    var trackName: String
    var collectionName: String
}


