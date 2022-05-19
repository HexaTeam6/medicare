//
//  StartScreening.swift
//  medicare
//
//  Created by Abdur Rachman Wahed on 17/05/22.
//

import SwiftUI

// MARK: Start Screening
struct StartScreening: View {
    @Binding var isActive: Bool
    
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
                NavigationLink(destination: ScreeningView(rootIsActive: $isActive), isActive: $isActive, label: {
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
//        .padding(.horizontal, 25)
        .padding(.top, 20)
    }
}

struct StartScreening_Previews: PreviewProvider {
    static var previews: some View {
        StartScreening(isActive: .constant(false))
    }
}
