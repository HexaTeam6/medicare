//
//  ScreeningView.swift
//  medicare
//
//  Created by Abdur Rachman Wahed on 06/05/22.
//

import SwiftUI

struct ScreeningView: View {
    
    @Binding var rootIsActive: Bool
    
    @State private var screening_question: [Screening] = Screening.sampleData
    @State private var currentQuestion: Int = 0
    
    @State private var selected: String = ""
    @State private var inputNumber: String = ""
    @State private var inputDate: Date = Date.now
    
    @State private var userAnswer: [Answer] = [Answer]()
    
    @FocusState private var numberIsFocused: Bool
    
    @State private var showingAlert: Bool = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("Light-Blue")
                
                VStack(spacing: 0) {
                    VStack(alignment: .leading, spacing: 0) {
                        Group{
                            ProgressCounter(current: $currentQuestion, total: screening_question.count)
                                .padding(.vertical, 20)
                            
                            Text("\(screening_question[currentQuestion].pertanyaan)")
                                .font(.system(size: 18, weight: .bold, design: .rounded))
                                .foregroundColor(Color("Navy"))
                            
                            AnswerInput(selected: $selected, inputNumber: $inputNumber, inputDate: $inputDate, input: $screening_question[currentQuestion].input, jenisInput: $screening_question[currentQuestion].jenisInput, numberIsFocused: $numberIsFocused)
                        }
                        .padding(.horizontal, 20)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(.white)
                    .cornerRadius(10)
                    
                    NavigationButton(selected: $selected,
                                     inputNumber: $inputNumber,
                                     inputDate: $inputDate,
                                     userAnswer: $userAnswer,
                                     currentQuestion: $currentQuestion,
                                     showingAlert: $showingAlert,
                                     totalQuestion: screening_question.count,
                                     rootIsActive: $rootIsActive)
                }
                .padding(.horizontal, 25)
            }
            .ignoresSafeArea()
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    
                    Button("Done") {
                        numberIsFocused = false
                    }
                    .accessibilityAddTraits(.isKeyboardKey)
                }
            }
            .alert("Error", isPresented: $showingAlert) {
                Button("OK"){ }
            } message: {
                Text("Invalid input!")
            }
        }
    }
}

struct ScreeningView_Previews: PreviewProvider {
    static var previews: some View {
        ScreeningView(rootIsActive: .constant(false))
    }
}

// MARK: Answer Input
struct AnswerInput: View {
    @Binding var selected: String
    @Binding var inputNumber: String
    @Binding var inputDate: Date
    
//    let formatter: NumberFormatter = {
//        let formatter = NumberFormatter()
//        formatter.numberStyle = .decimal
//        return formatter
//    }()
    
    @Binding var input: [Input]
    @Binding var jenisInput: String
    
    @FocusState.Binding var numberIsFocused: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            if (jenisInput == "Option") {
                ForEach($input.indices, id: \.self) { index in
                    Button(action: {
                        self.selected = input[index].option
                    }, label: {
                        Text(input[index].option)
                            .font(.system(size: 16, weight: .regular, design: .rounded))
                            .foregroundColor(self.selected == input[index].option ? Color("Purple") : Color("Gray"))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(15)
                            .background(self.selected == input[index].option ? Color("Purple").opacity(0.20) : Color("Light-Gray"))
                            .cornerRadius(10)
                    })
                }
            }
            else if (jenisInput == "Number") {
                TextField(". . .", text: $inputNumber)
                    .keyboardType(.decimalPad)
                    .focused($numberIsFocused)
                    .padding(15)
                    .background(Color("Light-Gray"))
                    .cornerRadius(10)
                    .accessibilityLabel("input field")
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

// MARK: Navigation Button
struct NavigationButton: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @Binding var selected: String
    @Binding var inputNumber: String
    @Binding var inputDate: Date
    
    @Binding var userAnswer: [Answer]
    
    @Binding var currentQuestion: Int
    @Binding var showingAlert: Bool
    let totalQuestion: Int
    
    @Binding var rootIsActive: Bool
    
    var body: some View {
        VStack(spacing: 0){
            Button(action: {
                let dateFormatter = DateFormatter()
                var answer: Answer = Answer()
                dateFormatter.dateFormat = "dd-MM-yyyy"
                
                // cek input berasal dari tipe input
                if inputNumber != "" {
                    answer = Answer(input: inputNumber)
                    inputNumber = ""
                }
                else if selected != "" {
                    answer = Answer(input: selected)
                    selected = ""
                }
                else if dateFormatter.string(from: inputDate) != dateFormatter.string(from: Date.now) {
                    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
                    answer = Answer(input: dateFormatter.string(from: inputDate))
                    inputDate = Date.now
                }
                
                //print(answer.input)
                
                // tampilkan alert jika user tidak menginput jawaban
                if answer.input == "" {
                    showingAlert = true
                    return
                }
                
                // cek apakah sudah pernah di jawab sebelumnya
                if userAnswer.indices.contains(currentQuestion) {
                    userAnswer[currentQuestion] = answer
                }
                else {
                    userAnswer.append(answer)
                }
                
                // lanjut ke pertanyaan selanjutnya
                if(currentQuestion < totalQuestion - 1) {
                    currentQuestion += 1
                }
                else {
                    addHasil(viewContext: viewContext, userAnswer: userAnswer)
                    rootIsActive = false
                }
                
            }, label: {
                Text(currentQuestion < totalQuestion - 1 ? "Next" : "Submit")
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
                    print(currentQuestion)
                }, label: {
                    Text("Previous")
                        .font(.system(size: 16, weight: .light, design: .rounded))
                        .foregroundColor(Color("Navy"))
                        .padding(10)
                })
            }
        }
        .padding(.top, 20)
    }
}
