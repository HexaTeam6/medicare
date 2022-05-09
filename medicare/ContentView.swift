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
                        .accessibility(sortPriority: 4)
                    
                    HStack(spacing: 20) {
                        Card(penyakit: "Diabetes", risiko: hasilScreening.hasilDiabetes, tanggalPeriksa: "09 May, 2022")
                            .accessibility(sortPriority: 3)
                        
                        Card(penyakit: "Cholesterol", risiko: hasilScreening.hasilKolesterol, tanggalPeriksa: hasilScreening.tglScreening)
                            .accessibility(sortPriority: 2)
                    }
                    .padding(.top, 20)
                    
                    HStack(spacing: 20) {
                        Card(penyakit: "Stroke", risiko: hasilScreening.hasilStroke, tanggalPeriksa: hasilScreening.tglScreening)
                            .accessibility(sortPriority: 1)
                        
                        Card(penyakit: "Fitness", risiko: "", tanggalPeriksa: "Feature not yet available")
                            .accessibility(sortPriority: 0)
                    }
                    .padding(.top, 20)
                    
                    StartScreening(isActive: $isActive, hasilScreening: $hasilScreening)
                    
                    Spacer()
                }
                .accessibilityElement(children: .contain)
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

// MARK: Header
struct Header: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text(greetingLogic())
                .font(.system(size: 32, weight: .light, design: .rounded))
            Text("Wahed")
                .font(.system(size: 32, weight: .bold, design: .rounded))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .foregroundColor(Color("Navy"))
        .padding(.horizontal, 25)
        .padding(.top, 108)
    }
    
    func greetingLogic() -> String {
      let hour = Calendar.current.component(.hour, from: Date())
      
      let newDay = 0
      let noon = 12
      let sunset = 18
      let midnight = 24
      
      var greetingText = "Hello," // Default greeting text
      switch hour {
      case newDay..<noon:
          greetingText = "Good morning,"
      case noon..<sunset:
          greetingText = "Good afternoon,"
      case sunset..<midnight:
          greetingText = "Good evening,"
      default:
          _ = "Hello,"
      }
      
      return greetingText
    }
}

// MARK: CARD
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
                    .accessibilityHidden(true)
                
                Text(penyakit)
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                    .foregroundColor(Color("Navy"))
                
                Text(risiko)
                    .font(.system(size: 16, weight: .regular, design: .rounded))
                    .foregroundColor(Color("Purple"))
                    .accessibilityHidden(risiko == "" ? true : false)
                
                Text(tanggalPeriksa)
                    .font(.system(size: 14, weight: .regular, design: .rounded))
                    .foregroundColor(Color("Gray"))
                    .padding(.top, 1)
                    .accessibilityHidden(tanggalPeriksa == "" ? true : false)
                    .accessibilityLabel("screened on \(tanggalPeriksa)")
            }
            .padding(.leading, 15)
        }
        .frame(width: 160, height: 141, alignment: .leading)
        .background(.white)
        .cornerRadius(10)
    }
}

// MARK: Start Screening
struct StartScreening: View {
    @Binding var isActive: Bool
    @Binding var hasilScreening: HasilScreening
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Risk Screening")
                    .font(.system(size: 18, weight: .medium, design: .rounded))
                
                Text("Diabetes, cholesterol, stroke")
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
            .accessibilityLabel("start screening")
        }
        .background(Color("Purple").opacity(0.20))
        .cornerRadius(10)
        .padding(.horizontal, 25)
        .padding(.top, 20)
    }
}
