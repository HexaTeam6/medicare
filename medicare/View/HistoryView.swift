//
//  HistoryView.swift
//  medicare
//
//  Created by Abdur Rachman Wahed on 17/05/22.
//

import SwiftUI
import SwiftUICharts

struct HistoryView: View {
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Hasil.created_at, ascending: false)],
            animation: .default)
        private var hasil: FetchedResults<Hasil>
    
    let risiko: String
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("Light-Blue")
                
                VStack(spacing: 0) {
                    Spacer()
                    
                    LineChart(dataset: toDatapoints(hasil: hasil, risiko: risiko), risiko: risiko)
                        .frame(height: 358)
                        .padding(.top, 100)
                    
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Result History")
                            .font(.system(size: 18, weight: .bold, design: .rounded))
                            .foregroundColor(Color("Navy"))
                            .padding([.leading, .top], 20)
                            .padding(.bottom, 10)
                        
                        VStack(spacing: 5) {
                            ScrollView {
                                ForEach(hasil) { item in
                                    if risiko == "Diabetes" {
                                        RowHistory(risiko: item.hasilDiabetes ?? "", tglScreening: item.tglScreening ?? "")
                                    }
                                    else if risiko == "Stroke" {
                                        RowHistory(risiko: item.hasilStroke ?? "", tglScreening: item.tglScreening ?? "")
                                    }
                                    else if risiko == "Cholesterol" {
                                        RowHistory(risiko: item.hasilKolesterol ?? "", tglScreening: item.tglScreening ?? "")
                                    }
                                }
                            }
                        }
                        .padding(.bottom, 20)
                        .frame(maxHeight: .infinity)
                        
                        
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background()
                    .cornerRadius(10)
                    .padding([.leading, .trailing], 25)
                    .padding(.top, 20)
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .ignoresSafeArea()
            .frame(maxHeight: .infinity)
        }
    }
    
    func toDatapoints(hasil: FetchedResults<Hasil>, risiko: String) -> [Double] {
        var datapoints: [Double] = [Double]()
        
        for item in hasil {
            if risiko == "Diabetes" {
                datapoints.append(Double(item.scoreDiabetes))
            }
            else if risiko == "Stroke" {
                datapoints.append(Double(item.scoreHStroke))
            }
            else if risiko == "Cholesterol" {
                datapoints.append(Double(item.scoreKolesterol))
            }
            
        }
        
        return datapoints.reversed()
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView(risiko: "Diabetes")
    }
}
