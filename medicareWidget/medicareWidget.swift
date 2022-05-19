//
//  medicareWidget.swift
//  medicareWidget
//
//  Created by Abdur Rachman Wahed on 19/05/22.
//

import WidgetKit
import SwiftUI

struct RiskEntry: TimelineEntry {
    let date: Date = Date()
    let hasilScreening: HasilScreening
}

struct Provider: TimelineProvider {
    
    @AppStorage("hasilScreening", store: UserDefaults(suiteName: "group.com.hexateam6.medicare"))
    var dataStorage: Data = Data()
    
    func placeholder(in context: Context) -> RiskEntry {
        RiskEntry(hasilScreening: HasilScreening())
    }
    
    func getSnapshot(in context: Context, completion: @escaping (RiskEntry) -> Void) {
        guard let hasilScreening = try? JSONDecoder().decode(HasilScreening.self, from: dataStorage) else { return }
        let entry = RiskEntry(hasilScreening: hasilScreening)
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<RiskEntry>) -> Void) {
        guard let hasilScreening = try? JSONDecoder().decode(HasilScreening.self, from: dataStorage) else { return }
        let entry = RiskEntry(hasilScreening: hasilScreening)
        let timeline = Timeline(entries: [entry], policy: .atEnd)
        completion(timeline)
    }
}

struct RiskCard: View {
    let data: (jenis: String, risiko: String, tglScreening: String)
    
    var body: some View {
        VStack(alignment: .leading) {
            Group {
                Image("icon-\(data.jenis.lowercased())")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25, height: 25)
                
                Text(data.jenis)
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                    .foregroundColor(Color("Navy"))
                
                Text(data.risiko)
                    .font(.system(size: 16, weight: .regular, design: .rounded))
                    .foregroundColor(Color("Purple"))
                
                Text(data.tglScreening)
                    .font(.system(size: 14, weight: .regular, design: .rounded))
                    .foregroundColor(Color("Gray"))
                    .padding(.top, 1)
            }
            .padding(.leading, 15)
        }
        .frame(width: 160, height: 141, alignment: .leading)
        .background(.white)
        .cornerRadius(10)
    }
}

struct WidgetEntryView: View {
    var entry: Provider.Entry
    
    @Environment(\.widgetFamily) var family
    
    @ViewBuilder
    var body: some View {
        switch family {
        case .systemSmall:
            RiskCard(data: selectData(entry: entry))
        case .systemMedium:
            ZStack {
                Color("Light-Blue")

                HStack {
                    RiskCard(data: (jenis: "Diabetes", risiko: entry.hasilScreening.hasiDiabetes, tglScreening: entry.hasilScreening.tglScreening))
                    RiskCard(data: (jenis: "Cholesterol", risiko: entry.hasilScreening.hasilKolesterol, tglScreening: entry.hasilScreening.tglScreening))
                }
            }
        case .systemLarge:
            ZStack {
                Color("Light-Blue")
                
                VStack(alignment: .leading) {
                    HStack {
                        RiskCard(data: (jenis: "Diabetes", risiko: entry.hasilScreening.hasiDiabetes, tglScreening: entry.hasilScreening.tglScreening))
                        RiskCard(data: (jenis: "Cholesterol", risiko: entry.hasilScreening.hasilKolesterol, tglScreening: entry.hasilScreening.tglScreening))
                    }
                    RiskCard(data: (jenis: "Stroke", risiko: entry.hasilScreening.hasilStroke, tglScreening: entry.hasilScreening.tglScreening))
                }
            }
        default:
            RiskCard(data: selectData(entry: entry))
        }
    }
    
    func selectData(entry: Provider.Entry) -> (jenis: String, risiko: String, tglScreening: String){
        if entry.hasilScreening.hasiDiabetes == "High risk" {
            return (jenis: "Diabetes", risiko: "High risk", tglScreening: entry.hasilScreening.tglScreening)
        }
        else if entry.hasilScreening.hasilKolesterol == "High risk" {
            return (jenis: "Cholesterol", risiko: "High risk", tglScreening: entry.hasilScreening.tglScreening)
        }
        else if entry.hasilScreening.hasilStroke == "High risk" {
            return (jenis: "Stroke", risiko: "High risk", tglScreening: entry.hasilScreening.tglScreening)
        }
        else {
            return (jenis: "Diabetes", risiko: entry.hasilScreening.hasiDiabetes, tglScreening: entry.hasilScreening.tglScreening)
        }
    }
}

@main
struct medicareWidget: Widget {
    private let kind = "medicareWidget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            WidgetEntryView(entry: entry)
        }
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    }
}

struct medicareWidget_Previews: PreviewProvider {
    static var previews: some View {
        WidgetEntryView(entry: RiskEntry(hasilScreening: HasilScreening()))
            .environment(\.sizeCategory, .small)
            .previewContext(WidgetPreviewContext(family: .systemLarge))
    }
}
