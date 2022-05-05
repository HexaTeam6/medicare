//
//  ScreeningView.swift
//  medicare
//
//  Created by Abdur Rachman Wahed on 06/05/22.
//

import SwiftUI

struct ScreeningView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Color("Light-Blue")
                
                VStack(spacing: 0) {
                    VStack(alignment: .leading, spacing: 0) {
                        Group{
                            ProgressCounter()
                                .padding(.vertical, 20)
                            
                            Text("Apakah anda merokok?")
                                .font(.system(size: 18, weight: .bold, design: .rounded))
                                .foregroundColor(Color("Navy"))
                            
                            AnswerInput()
                        }
                        .padding(.horizontal, 20)
                    }
                    .background(.white)
                    .cornerRadius(10)
                    
                    VStack(spacing: 0){
                        Button(action: {
                            
                        }, label: {
                            Text("Selanjutnya")
                                .font(.system(size: 16, weight: .medium, design: .rounded))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding(20)
                                .background(Color("Navy"))
                                .cornerRadius(10)
                        })
                        
                        Button(action: {
                            
                        }, label: {
                            Text("Sebelumnya")
                                .font(.system(size: 16, weight: .light, design: .rounded))
                                .foregroundColor(Color("Navy"))
                                .padding(10)
                        })
                    }
                    .padding(.top, 20)
                }
                .padding(.horizontal, 25)

            }
            .ignoresSafeArea()
        }
    }
}

struct ScreeningView_Previews: PreviewProvider {
    static var previews: some View {
        ScreeningView()
    }
}

struct ProgressCounter: View {
    var body: some View {
        HStack {
            VStack(spacing: 0) {
                Text("08")
                    .font(.system(size: 24, weight: .bold, design: .rounded))
                    .foregroundColor(Color("Navy"))
                
                RoundedRectangle(cornerRadius: 50)
                    .frame(width: 30, height: 3)
                    .padding(.top, 3)
                    .foregroundColor(Color("Purple"))
            }
            
            Text("dari 15")
                .font(.system(size: 16, weight: .light, design: .rounded))
                .foregroundColor(Color("Gray"))
        }
    }
}

struct AnswerInput: View {
    @State var selected: String?
    @State var items: [String] = ["Sering", "Jarang", "Sekali", "Tidak pernah"]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            ForEach(items, id: \.self) { item in
                Button(action: {
                    self.selected = item
                }, label: {
                    Text(item)
                        .font(.system(size: 16, weight: .regular, design: .rounded))
                        .foregroundColor(self.selected == item ? Color("Purple") : Color("Gray"))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(15)
                        .background(self.selected == item ? Color("Purple").opacity(0.20) : Color("Light-Gray"))
                        .cornerRadius(10)
                })
            }
        }
        .padding(.vertical, 20)
    }
}
