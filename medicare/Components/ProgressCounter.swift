//
//  ProgressCounter.swift
//  medicare
//
//  Created by Abdur Rachman Wahed on 17/05/22.
//

import SwiftUI

// MARK: Progress Counter
struct ProgressCounter: View {
    @Binding var current: Int
    let total: Int
    
    var body: some View {
        HStack {
            VStack(spacing: 0) {
                Text("\(current + 1)")
                    .font(.system(size: 24, weight: .bold, design: .rounded))
                    .foregroundColor(Color("Navy"))
                
                RoundedRectangle(cornerRadius: 50)
                    .frame(width: 30, height: 3)
                    .padding(.top, 3)
                    .foregroundColor(Color("Purple"))
            }
            
            Text("of \(total)")
                .font(.system(size: 16, weight: .light, design: .rounded))
                .foregroundColor(Color("Gray"))
        }
    }
}

struct ProgressCounter_Previews: PreviewProvider {
    static var previews: some View {
        ProgressCounter(current: .constant(0), total: 20)
    }
}
