//
//  ContentView.swift
//  Cryptoracle
//
//  Created by Daniel on 11/09/23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var network: Network
    /*@FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>*/

    var body: some View {
        NavigationView {
            List{
                ForEach(network.cryptocurrencies) { cryptocurrency in
                    NavigationLink {
                        ScrollView {
                            VStack {
                                Text("\(cryptocurrency.name.capitalized) - \(cryptocurrency.symbol.uppercased())")
                                    .font(.title)
                                AsyncImage(url: URL(string: cryptocurrency.image)) { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                } placeholder: {
                                    Image(systemName: "slowmo")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                }
                                .frame(width: 50, height: 50)
                                Text("Current price: $\(cryptocurrency.current_price)")
                                Text("Last Updated: \(cryptocurrency.last_updated)")
                                    .lineLimit(1)
                                Text("Total volume: \(cryptocurrency.total_volume)")
                                Text("Highest price: $\(cryptocurrency.high_24h)")
                                Text("Lowest price: $\(cryptocurrency.low_24h)")
                                Text("Price change: \(cryptocurrency.price_change_24h)")
                                Text("Market cap: \(cryptocurrency.market_cap)")
                            }
                        }
                        
                    } label: {
                        VStack {
                            HStack {
                                AsyncImage(url: URL(string: cryptocurrency.image)) { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                    
                                } placeholder: {
                                    Image(systemName: "slowmo")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                }
                                .frame(width: 20, height: 20)
                                Text("\(cryptocurrency.name) - \(cryptocurrency.symbol.uppercased())")
                            }
                            HStack {
                                Text("$\(cryptocurrency.current_price)")
                                Text("\(cryptocurrency.last_updated)")
                                    .lineLimit(1)
                            }
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: loadCryptocurrencies) {
                        Image(systemName: "coloncurrencysign.circle")
                    }
                }
                ToolbarItem(placement: .principal) {
                    Text("CRYPTOCURRENCIES")
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: loadCryptocurrencies) {
                        Image(systemName: "goforward")
                    }
                }
            }
        }
        .onAppear {
            loadCryptocurrencies()
        }
    }
    
    private func loadCryptocurrencies() {
        network.getCryptocurrencies()
    }
    
    private let itemFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .medium
        return formatter
    }()
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
            .environmentObject(Network())
    }
}
