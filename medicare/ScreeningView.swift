//
//  ScreeningView.swift
//  medicare
//
//  Created by Abdur Rachman Wahed on 06/05/22.
//

import SwiftUI

struct ScreeningView: View {
    @Binding var rootIsActive: Bool
    @Binding var hasilScreening: HasilScreening
    
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
                                     hasilScreening: $hasilScreening,
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
                }
            }
            .alert("Error", isPresented: $showingAlert) {
                Button("OK"){ }
            } message: {
                Text("Input tidak sesuai!")
            }
        }
    }
}

struct ScreeningView_Previews: PreviewProvider {
    static var previews: some View {
        ScreeningView(rootIsActive: .constant(false), hasilScreening: .constant(HasilScreening()))
    }
}

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
            
            Text("dari \(total)")
                .font(.system(size: 16, weight: .light, design: .rounded))
                .foregroundColor(Color("Gray"))
        }
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
    @Binding var selected: String
    @Binding var inputNumber: String
    @Binding var inputDate: Date
    
    @Binding var userAnswer: [Answer]
    
    @Binding var currentQuestion: Int
    @Binding var showingAlert: Bool
    let totalQuestion: Int
    
    @Binding var hasilScreening: HasilScreening
    @Binding var rootIsActive: Bool
    
    var body: some View {
        VStack(spacing: 0){
            Button(action: {
                let dateFormatter = DateFormatter()
                var answer: Answer = Answer()
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
                
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
                    answer = Answer(input: dateFormatter.string(from: inputDate))
                    inputDate = Date.now
                }
                
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
                    hasilScreening.hasilDiabetes = calcDiabetes(userAnswer: userAnswer)
                    
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "dd-MM-yyyy"
                    hasilScreening.tglScreening = dateFormatter.string(from: Date())
                    
                    rootIsActive = false
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
                    print(currentQuestion)
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
    
    func calcDiabetes(userAnswer: [Answer]) -> String {
        var score: Int = 0
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let birthday = dateFormatter.date(from: userAnswer[1].input)!
        let calendar = Calendar.current
        let ageComponents = calendar.dateComponents([.year], from: birthday, to: Date())
        
        let age = ageComponents.year!
        
        // umur
        if age > 64 {
            score += 4
        }
        else if age >= 55 {
            score += 3
        }
        else if age >= 45 {
            score += 2
        }
        
        // BMI
        let bmi: Double = Double(userAnswer[3].input)! / pow(Double(userAnswer[2].input)! / 100, 2.0)
        if bmi > 30 {
            score += 3
        }
        else if bmi >= 25 {
            score += 1
        }
        
        // lingkar pinggang
        if userAnswer[0].input == "Laki-laki" {
            if Int(userAnswer[4].input)! > 102 {
                score += 4
            }
            else if Int(userAnswer[4].input)! >= 94 {
                score += 3
            }
        }
        else if userAnswer[0].input == "Perempuan" {
            if Int(userAnswer[4].input)! > 88 {
                score += 4
            }
            else if Int(userAnswer[4].input)! >= 80 {
                score += 3
            }
        }
        
        // aktivitas fisik
        if userAnswer[5].input == "Tidak" {
            score += 2
        }
        
        // makan sayuran dan buah buahan
        if userAnswer[7].input == "Tidak setiap hari" {
            score += 1
        }
        
        // pernah mengalami tekanan darah tinggi
        if userAnswer[9].input == "Ya" {
            score += 2
        }
        
        // pernah punya darah tinggi
        if userAnswer[11].input == "Ya" {
            score += 5
        }
        
        // keturunan diabetes
        if userAnswer[17].input == "Ya (Orang tua, Kakak, Adik, atau Anak kandung)" {
            score += 5
        }
        else if userAnswer[17].input == "Ya (Kakek/Nenek, Bibi, Paman, atau sepupu dekat)" {
            score += 3
        }
        
        if score >= 15 { return "Risiko tinggi" }
        else if score >= 12 { return "Risiko sedang" }
        else { return "Risiko rendah" }
    }
}
