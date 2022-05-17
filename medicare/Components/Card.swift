//
//  Card.swift
//  medicare
//
//  Created by Abdur Rachman Wahed on 17/05/22.
//

import SwiftUI

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

struct Card_Previews: PreviewProvider {
    static var previews: some View {
        Card(penyakit: "Diabetes", risiko: "Not screened yet", tanggalPeriksa: "")
    }
}
