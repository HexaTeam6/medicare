//
//  ContentView.swift
//  medicare
//
//  Created by Abdur Rachman Wahed on 05/05/22.
//

import SwiftUI

struct ContentView: View {
    @State var isActive: Bool = false
    @State var hasilScreening: HasilScreening = HasilScreening()
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("Light-Blue")
                
                VStack(spacing: 0) {
                    Header()
                    
                    HStack(spacing: 20) {
                        Card(penyakit: "Diabetes", risiko: hasilScreening.hasilDiabetes, tanggalPeriksa: hasilScreening.tglScreening)
                        Card(penyakit: "Kolesterol", risiko: hasilScreening.hasilKolesterol, tanggalPeriksa: hasilScreening.tglScreening)
                    }
                    .padding(.top, 20)
                    
                    HStack(spacing: 20) {
                        Card(penyakit: "Stroke", risiko: hasilScreening.hasilStroke, tanggalPeriksa: hasilScreening.tglScreening)
                        Card(penyakit: "Kebugaran", risiko: "", tanggalPeriksa: "Fitur belum tersedia")
                    }
                    .padding(.top, 20)
                    
                    StartScreening(isActive: $isActive, hasilScreening: $hasilScreening)
                    
                    Spacer()
                }
            }
            .ignoresSafeArea()
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

struct Header: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Selamat pagi,")
                .font(.system(size: 32, weight: .light, design: .rounded))
            Text("Wahed")
                .font(.system(size: 32, weight: .bold, design: .rounded))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .foregroundColor(Color("Navy"))
        .padding(.horizontal, 25)
        .padding(.top, 108)
    }
}

struct Card: View {
    let penyakit: String
    let risiko: String
    let tanggalPeriksa: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Group {
                Image("icon-\(penyakit.lowercased())")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25, height: 25)
                
                Text(penyakit)
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                    .foregroundColor(Color("Navy"))
                
                Text(risiko)
                    .font(.system(size: 16, weight: .regular, design: .rounded))
                    .foregroundColor(Color("Purple"))
                
                Text(tanggalPeriksa)
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

struct StartScreening: View {
    @Binding var isActive: Bool
    @Binding var hasilScreening: HasilScreening
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Screening Risiko")
                    .font(.system(size: 18, weight: .medium, design: .rounded))
                
                Text("Diabetes, kolesterol, stroke")
                    .font(.system(size: 14, weight: .light, design: .rounded))
            }
            .foregroundColor(Color("Navy"))
            .padding(.leading, 20)
            .padding(.vertical, 25)
            
            Spacer()
            
            Button(action: {
                print("button pressed")
                
            }) {
                NavigationLink(destination: ScreeningView(rootIsActive: $isActive, hasilScreening: $hasilScreening), isActive: $isActive, label: {
                    Image(systemName: "chevron.right")
                        .foregroundColor(.white)
                        .font(.system(size: 30))
                        .padding(.horizontal, 15)
                        .padding(.vertical, 10)
                })
            }
            .background(Color("Navy"))
            .cornerRadius(10)
            .padding()
        }
        .background(Color("Purple").opacity(0.20))
        .cornerRadius(10)
        .padding(.horizontal, 25)
        .padding(.top, 20)
    }
}
