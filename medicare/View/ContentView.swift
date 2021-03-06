//
//  ContentView.swift
//  medicare
//
//  Created by Abdur Rachman Wahed on 05/05/22.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Hasil.created_at, ascending: false)],
            animation: .default)
        private var hasil: FetchedResults<Hasil>
    
    @State var isActive: Bool = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 0) {
                    
                    Group {
                        Header()
                            .accessibility(sortPriority: 4)
                        
                        HStack(spacing: 20) {
                            Card(penyakit: "Diabetes", risiko: hasil.first?.hasilDiabetes ?? "Not screened yet", tanggalPeriksa: hasil.first?.tglScreening ?? "")
                                .accessibility(sortPriority: 3)
                            
                            Card(penyakit: "Cholesterol", risiko: hasil.first?.hasilKolesterol ?? "Not screened yet", tanggalPeriksa: hasil.first?.tglScreening ?? "")
                                .accessibility(sortPriority: 2)
                        }
                        .padding(.top, 20)
                        
                        HStack(spacing: 20) {
                            Card(penyakit: "Stroke", risiko: hasil.first?.hasilStroke ?? "Not screened yet", tanggalPeriksa: hasil.first?.tglScreening ?? "")
                                .accessibility(sortPriority: 1)
                            
                            Card(penyakit: "Fitness", risiko: "", tanggalPeriksa: "Feature not yet available")
                                .accessibility(sortPriority: 0)
                        }
                        .padding(.top, 20)
                        
                        StartScreening(isActive: $isActive)
                    }
                    .padding(.horizontal, 25)
                    
                    Text("History")
                        .font(.system(size: 18, weight: .semibold, design: .rounded))
                        .foregroundColor(Color("Navy"))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 20)
                        .padding(.leading, 25)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 20) {
                            NavigationLink(destination: HistoryView(risiko: "Diabetes"), label:{
                                HistoryCard(penyakit: "Diabetes")
                                    .padding(.leading, 25)
                            })
                            
                            NavigationLink(destination: HistoryView(risiko: "Cholesterol"), label:{
                                HistoryCard(penyakit: "Cholesterol")
                            })
                            
                            NavigationLink(destination: HistoryView(risiko: "Stroke"), label:{
                                HistoryCard(penyakit: "Stroke")
                            })
                        }
                    }
                    .padding(.top, 10)
                    
                    Spacer()
                }
                .accessibilityElement(children: .contain)
            }
            .ignoresSafeArea()
            .frame(maxHeight: .infinity)
            .background( Color("Light-Blue"))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
