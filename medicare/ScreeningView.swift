//
//  ScreeningView.swift
//  medicare
//
//  Created by Abdur Rachman Wahed on 06/05/22.
//

import SwiftUI

struct ScreeningView: View {
    @State private var screening_data: [Screening] = Screening.sampleData
    @State private var currentQuestion: Int = 0
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("Light-Blue")
                
                VStack(spacing: 0) {
                    VStack(alignment: .leading, spacing: 0) {
                        Group{
                            ProgressCounter(current: $currentQuestion, total: screening_data.count)
                                .padding(.vertical, 20)
                            
                            Text("\(screening_data[currentQuestion].pertanyaan)")
                                .font(.system(size: 18, weight: .bold, design: .rounded))
                                .foregroundColor(Color("Navy"))
                            
                            AnswerInput(input: $screening_data[currentQuestion].input, jenisInput: $screening_data[currentQuestion].jenisInput)
                        }
                        .padding(.horizontal, 20)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(.white)
                    .cornerRadius(10)
                    
                    NavigationButton(currentQuestion: $currentQuestion, totalQuestion: screening_data.count)
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
            
            Text("dari \(total)")
                .font(.system(size: 16, weight: .light, design: .rounded))
                .foregroundColor(Color("Gray"))
        }
    }
}

struct AnswerInput: View {
    @State var selected: Int?
    @State var inputNumber: Int?
    @State var inputDate = Date.now
    
    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    @Binding var input: [Input]
    @Binding var jenisInput: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            if (jenisInput == "Option") {
                ForEach($input.indices, id: \.self) { index in
                    Button(action: {
                        self.selected = index
                    }, label: {
                        Text(input[index].option)
                            .font(.system(size: 16, weight: .regular, design: .rounded))
                            .foregroundColor(self.selected == index ? Color("Purple") : Color("Gray"))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(15)
                            .background(self.selected == index ? Color("Purple").opacity(0.20) : Color("Light-Gray"))
                            .cornerRadius(10)
                    })
                }
            }
            else if (jenisInput == "Number") {
                TextField(". . .", value: $inputNumber, formatter: formatter)
                    .keyboardType(.decimalPad)
                    .padding(15)
                    .background(Color("Light-Gray"))
                    .cornerRadius(10)
            }
            else if (jenisInput == "Date") {
                DatePicker("", selection: $inputDate, in: ...Date(), displayedComponents: .date)
                    .labelsHidden()
                    .id(inputDate)
            }
        }
        .padding(.vertical, 20)
    }
}

struct NavigationButton: View {
    @Binding var currentQuestion: Int
    let totalQuestion: Int
    
    var body: some View {
        VStack(spacing: 0){
            Button(action: {
                if(currentQuestion < totalQuestion - 1) {
                    currentQuestion += 1
                }
            }, label: {
                Text(currentQuestion < totalQuestion - 1 ? "Selanjutnya" : "Simpan")
                    .font(.system(size: 16, weight: .medium, design: .rounded))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(20)
                    .background(Color("Navy"))
                    .cornerRadius(10)
            })
            
            if(currentQuestion > 0) {
                Button(action: {
                    currentQuestion -= 1
                }, label: {
                    Text("Sebelumnya")
                        .font(.system(size: 16, weight: .light, design: .rounded))
                        .foregroundColor(Color("Navy"))
                        .padding(10)
                })
            }
        }
        .padding(.top, 20)
    }
}
