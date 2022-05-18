//
//  HistoryView.swift
//  medicare
//
//  Created by Abdur Rachman Wahed on 17/05/22.
//

import SwiftUI
import SwiftUICharts

struct HistoryView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Color("Light-Blue")
                
                VStack(spacing: 0) {
                    LineChart()
                    
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Result History")
                            .font(.system(size: 18, weight: .bold, design: .rounded))
                            .foregroundColor(Color("Navy"))
                            .padding([.leading, .top], 20)
                            .padding(.bottom, 10)
                        
                        VStack(spacing: 5) {
                            RowHistory(risiko: "High risk", tglScreening: "04 May, 2022")
                            RowHistory(risiko: "Medium risk", tglScreening: "03 May, 2022")
                            RowHistory(risiko: "Low risk", tglScreening: "02 May, 2022")
                            RowHistory(risiko: "High risk", tglScreening: "01 May, 2022")
                        }
                        .padding(.bottom, 20)
                        
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
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}
