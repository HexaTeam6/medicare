//
//  HistoryCard.swift
//  medicare
//
//  Created by Abdur Rachman Wahed on 17/05/22.
//

import SwiftUI

// MARK: CARD
struct HistoryCard: View {
    let penyakit: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            VStack(alignment: .leading, spacing: 0) {
                ZStack{
                    Color("Light-Blue")
                        .frame(width: 40, height: 40)
                        .cornerRadius(10)
                    
                    Image("icon-\(penyakit.lowercased())")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .accessibilityHidden(true)
                }
                .padding(.top, 15)
                
                Spacer()
                
                Text(penyakit)
                    .font(.system(size: 18, weight: .light, design: .rounded))
                    .foregroundColor(.white)
                
                Spacer()
            }
            .frame(maxHeight: .infinity)
            .padding(.leading, 15)
        }
        .frame(width: 120, height: 120, alignment: .leading)
        .background(Color("Navy"))
        .cornerRadius(10)
    }
}

struct HistoryCard_Previews: PreviewProvider {
    static var previews: some View {
        HistoryCard(penyakit: "Diabetes")
    }
}
