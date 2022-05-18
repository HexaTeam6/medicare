//
//  LineChart.swift
//  medicare
//
//  Created by Abdur Rachman Wahed on 18/05/22.
//

import SwiftUI
import SwiftUICharts

struct LineChart: View {
    var body: some View {
        VStack{
            let chartSytle = ChartStyle(backgroundColor: .white, accentColor: Colors.DarkPurple, secondGradientColor: Colors.GradientPurple, textColor: Color("Navy"), legendTextColor: Color("Navy"), dropShadowColor: Color("Purple"))
            
            LineView(data: [8,23,54,32,12,37,7,23,43], title: "History", legend:"Diabetes Score", style: chartSytle)
                .padding([.leading, .trailing, .bottom], 20)
        }
        .frame(maxWidth: .infinity, maxHeight: 358, alignment: .center)
        .background()
        .cornerRadius(10)
        .padding([.leading, .trailing], 25)
    }
}

struct LineChart_Previews: PreviewProvider {
    static var previews: some View {
        LineChart()
    }
}
