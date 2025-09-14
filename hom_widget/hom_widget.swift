//
//  hom_widget.swift
//  hom_widget
//
//  Created by yara on 9/14/25.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    let cryptoService = CryptoService()

    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), btcPrice: "0.0", ethPrice: "0.0",)
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), btcPrice: "0.0", ethPrice: "0.0")
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        
        
        cryptoService.fetchCryptoPrices { prices in
            if let prices = prices {
                let btcPrice = prices.first(where: { $0.instId == "BTC-USDT" })?.last ?? "N/A"
                let ethPrice = prices.first(where: { $0.instId == "ETH-USDT" })?.last ?? "N/A"

                let entry = SimpleEntry(date: Date(), btcPrice: btcPrice, ethPrice: ethPrice)
                let timeline = Timeline(entries: [entry], policy: .after(Date().addingTimeInterval(60)))
                completion(timeline)
            } else {
                
                print("Failed to fetch prices (nil returned)")
                let fallbackEntry = SimpleEntry(date: Date(), btcPrice: "N/A", ethPrice: "N/A")
                let timeline = Timeline(entries: [fallbackEntry], policy: .after(Date().addingTimeInterval(60)))
                completion(timeline)
            }
        }
    }

}


// Update your SimpleEntry struct to hold the new data
struct SimpleEntry: TimelineEntry {
    let date: Date
    let btcPrice: String
    let ethPrice: String
}


// Update your hom_widgetEntryView to display the new data
struct hom_widgetEntryView: View {
    var entry: Provider.Entry

    var body: some View {
        VStack(alignment: .leading) {
            Text("Crypto Prices 💰")
                .font(.headline)
            Spacer()
            HStack {
                Text("BTC:")
                    .font(.subheadline)
                Text("$\(entry.btcPrice)")
                    .font(.body)
            }
            HStack {
                Text("ETH:")
                    .font(.subheadline)
                Text("$\(entry.ethPrice)")
                    .font(.body)
            }
        }
    }
}

struct hom_widget: Widget {
    let kind: String = "hom_widget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                hom_widgetEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                hom_widgetEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

#Preview(as: .systemSmall) {
    hom_widget()
} timeline: {
    SimpleEntry(date: .now, btcPrice: "0.0", ethPrice: "0.0")
    SimpleEntry(date: .now, btcPrice: "0.0", ethPrice: "0.0")
}
