//
//  RowHistory.swift
//  medicare
//
//  Created by Abdur Rachman Wahed on 18/05/22.
//

import SwiftUI

struct RowHistory: View {
    let risiko: String
    let tglScreening: String
    
    var body: some View {
        HStack {
            Text(risiko)
                .font(.system(size: 16, weight: .bold, design: .rounded))
                .foregroundColor(risiko == "High risk" ? Color("Purple") : Color("Gray"))
                .padding()
            
            Spacer()
            
            Text(tglScreening)
                .font(.system(size: 16, weight: .regular, design: .rounded))
                .foregroundColor(risiko == "High risk" ? Color("Purple") : Color("Gray"))
                .padding()
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(risiko == "High risk" ? Color("Purple").opacity(0.2) : Color("Light-Gray"))
        .cornerRadius(10)
        .padding([.leading, .trailing], 20)
    }
}

struct RowHistory_Previews: PreviewProvider {
    static var previews: some View {
        RowHistory(risiko: "High risk", tglScreening: "10 May, 2022")
    }
}
