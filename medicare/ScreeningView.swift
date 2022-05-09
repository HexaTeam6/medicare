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
            
            Text("of \(total)")
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
                
                print(answer.input)
                
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
                    hasilScreening.hasilKolesterol = calcKolesterol(userAnswer: userAnswer)
                    hasilScreening.hasilStroke = calcStroke(userAnswer: userAnswer)
                    
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "dd MMM, yyyy"
                    hasilScreening.tglScreening = dateFormatter.string(from: Date())
                    
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
    
    // MARK: Calculate Diabetes
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
        if userAnswer[0].input == "Male" {
            if Int(userAnswer[4].input)! > 102 {
                score += 4
            }
            else if Int(userAnswer[4].input)! >= 94 {
                score += 3
            }
        }
        else if userAnswer[0].input == "Female" {
            if Int(userAnswer[4].input)! > 88 {
                score += 4
            }
            else if Int(userAnswer[4].input)! >= 80 {
                score += 3
            }
        }
        
        // aktivitas fisik
        if userAnswer[5].input == "No" {
            score += 2
        }
        
        // makan sayuran dan buah buahan
        if userAnswer[7].input == "Not Everyday" {
            score += 1
        }
        
        // pernah mengalami tekanan darah tinggi
        if userAnswer[9].input == "Yes" {
            score += 2
        }
        
        // pernah punya gula darat tinggi
        if userAnswer[11].input == "Yes" {
            score += 5
        }
        
        // keturunan diabetes
        if userAnswer[17].input == "Yes (Grandfather/Grandmother, Aunt, Uncle, or cousins)" {
            score += 5
        }
        else if userAnswer[17].input == "Yes (Parents, Brothers, Sisters or Biological Child)" {
            score += 3
        }
        
        if score >= 15 { return "High risk" }
        else if score >= 12 { return "Medium risk" }
        else { return "Low risk" }
    }
    
    
    // MARK: Calculate Kolesterol
    func calcKolesterol(userAnswer: [Answer]) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let birthday = dateFormatter.date(from: userAnswer[1].input)!
        let calendar = Calendar.current
        let ageComponents = calendar.dateComponents([.year], from: birthday, to: Date())
        
        let age = ageComponents.year!
        
        var isMale = false
        var smoker = true
        var hypertensive = false
        var diabetic = false
        let isBlack = false
        
        var sbp = 0
        var chol = 0
        var hdl = 0
        
        // jenis kelamin
        if userAnswer[0].input == "Male" {
            isMale = true
        }
        
        // merokok
        if userAnswer[6].input == "No" {
            smoker = false
        }
        
        // menggunakan obat hipertensi
        if userAnswer[8].input == "Yes" {
            hypertensive = false
        }
        
        // gula darah pernah tinggi
        if userAnswer[11].input == "Yes" {
            diabetic = true
        }
        
        // keturunan diabetes
        if userAnswer[17].input == "Yes (Grandfather/Grandmother, Aunt, Uncle, or cousins)" || userAnswer[17].input == "Yes (Parents, Brothers, Sisters or Biological Child)" {
            diabetic = true
        }
        
        // tekanan darah
        if userAnswer[12].input == "< 120/80" {
            sbp = 110
        }
        else if userAnswer[12].input == "120-139 / 80-89" {
            sbp = 130
        }
        else {
            sbp = 150
        }
        
        // kadar kolesterol
        if userAnswer[14].input == "< 200" {
            chol = 190
        }
        else if userAnswer[14].input == "200 - 239" {
            chol = 220
        }
        else {
            chol = 250
        }
        
        // kadar kolesterol hdl
        if userAnswer[15].input == "< 30" {
            hdl = 20
        }
        else if userAnswer[15].input == "30 - 50" {
            hdl = 40
        }
        else {
            hdl = 60
        }
        
        hdl = 40
        
        if age < 40 || age > 79 {
            return "No risk"
        }
        
        let lnAge = log(Double(age))
        let lnTotalChol = log(Double(chol))
        let lnHdl = log(Double(hdl))
        
        let trlnsbp: Double
        let ntlnsbp: Double
        
        if hypertensive {
            trlnsbp = log(Double(sbp))
        }
        else {
            trlnsbp = 0
        }
        
        if hypertensive {
            ntlnsbp = 0
        }
        else {
            ntlnsbp = log(Double(sbp))
        }
        
        let ageTotalChol = lnAge * lnTotalChol
        let ageHdl = lnAge * lnHdl
        let agetSbp = lnAge * trlnsbp
        let agentSbp = lnAge * ntlnsbp
        let ageSmoke: Double
        
        if smoker {
            ageSmoke = lnAge
        }
        else {
            ageSmoke = 0
        }
        
        var s010Ret: Double
        var mnxbRet: Double
        var predictRet: Double
        
        if isBlack && !isMale {
            s010Ret = 0.95334
            mnxbRet = 86.6081
            predictRet = (
                17.1141 * lnAge
                + 0.9396 * lnTotalChol
                + -18.9196 * lnHdl
                + 4.4748 * ageHdl
                + 29.2907 * trlnsbp
                + -6.4321 * agetSbp
                + 27.8197 * ntlnsbp
                + -6.0873 * agentSbp )
            
            if smoker {
                predictRet += 0.6908
            }
            
            if diabetic {
                predictRet += 0.8738
            }
        }
        else if !isBlack && !isMale {
            s010Ret = 0.96652
            mnxbRet = -29.1817
            predictRet = (
                -29.799 * lnAge
                 + 4.884 * pow(lnAge, 2.0)
                + 13.54 * lnTotalChol
                + -3.114 * ageTotalChol
                + -13.578 * lnHdl
                + 3.149 * ageHdl
                + 2.019 * trlnsbp
                + 1.957 * ntlnsbp
                + -1.665 * ageSmoke
            )
            if smoker {
                predictRet += 7.574
            }
            if diabetic {
                predictRet += 0.661
            }
        }
        else if isBlack && isMale {
            s010Ret = 0.89536
            mnxbRet = 19.5425
            predictRet = (
                2.469 * lnAge
                + 0.302 * lnTotalChol
                + -0.307 * lnHdl
                + 1.916 * trlnsbp
                + 1.809 * ntlnsbp
            )
            if smoker {
                predictRet += 0.549
            }
            if diabetic {
                predictRet += 0.645
            }
        }
        else {
            s010Ret = 0.91436
            mnxbRet = 61.1816
            predictRet = (
                12.344 * lnAge
                + 11.853 * lnTotalChol
                + -2.664 * ageTotalChol
                + -7.99 * lnHdl
                + 1.769 * ageHdl
                + 1.797 * trlnsbp
                + 1.764 * ntlnsbp
                + -1.795 * ageSmoke
            );
            if smoker {
                predictRet += 7.837
            }
            if diabetic {
                predictRet += 0.658
            }
        }
        
        let pct = 1 - pow(s010Ret, exp(predictRet - mnxbRet))
        let kolesterol_res = round(pct * 100 * 10) / 10
        var hasil = "";
        
        if kolesterol_res < 5 {
            hasil = "No risk"
        }
        else if kolesterol_res >= 5 && kolesterol_res < 7.4 {
            hasil = "Low risk"
        }
        else if kolesterol_res >= 7.5 && kolesterol_res < 19.9 {
            hasil = "Medium risk";
        }
        else if kolesterol_res >= 20 {
            hasil = "High risk"
        }
        
        return hasil
    }
    
    // MARK: Calculate Stroke
    func calcStroke (userAnswer: [Answer]) -> String {
        var high: Int = 0
        var medium: Int = 0
        var low: Int = 0
        
        // BMI
        let bmi: Double = Double(userAnswer[3].input)! / pow(Double(userAnswer[2].input)! / 100, 2.0)
        if bmi <= 25 {
            low += 1
        }
        else if bmi <= 30 {
            medium += 1
        }
        else {
            high += 1
        }
        
        // aktivitas fisik
        if userAnswer[5].input == "Yes" {
            low += 1
        }
        else if userAnswer[5].input == "Seldom" {
            medium += 1
        }
        else {
            high += 1
        }
        
        // merokok
        if userAnswer[6].input == "No" {
            low += 1
        }
        else if userAnswer[6].input == "Trying to quit smoking" {
            medium += 1
        }
        else {
            high += 1
        }
        
        // tekanan darah
        if userAnswer[12].input == "< 120/80" {
            low += 1
        }
        else if userAnswer[12].input == "120-139 / 80-89" {
            medium += 1
        }
        else {
            high += 1
        }
        
        // kadar kolesterol
        if userAnswer[14].input == "< 200" {
            low += 1
        }
        else if userAnswer[14].input == "200 - 239" {
            medium += 1
        }
        else {
            high += 1
        }
        
        // Riwayat stroke
        if userAnswer[16].input == "No" {
            low += 1
        }
        else if userAnswer[16].input == "Not Sure" {
            medium += 1
        }
        else {
            high += 1
        }
        
        // irama jantung
        if userAnswer[10].input == "No" {
            low += 1
        }
        else if userAnswer[10].input == "Not Sure" {
            medium += 1
        }
        else {
            high += 1
        }
        
        // kadar gula
        if userAnswer[13].input == "< 120" {
            low += 1
        }
        else if userAnswer[13].input == "120 - 150" {
            medium += 1
        }
        else {
            high += 1
        }
        
        var hasil = ""
        
        if high >= 3 {
            hasil = "High risk"
        }
        else {
            if high == 2 {
                if medium >= 3 {
                    hasil = "High risk"
                }
                else if medium >= 2 {
                    hasil = "Medium risk"
                }
                else {
                    hasil = "Low risk"
                }
            }
            else if high == 1 {
                if medium >= 5 {
                    hasil = "High risk"
                }
                else if medium >= 3 {
                    hasil = "Medium risk"
                }
                else {
                    hasil = "Low risk"
                }
            }
            else if medium >= 4 {
                hasil = "Medium risk"
            }
            else {
                if medium == 3 {
                    if low >= 3 {
                        hasil = "Medium risk"
                    }
                    else {
                        hasil = "Low risk"
                    }
                }
                else if medium == 2 {
                    if low >= 5 {
                        hasil = "Medium risk"
                    }
                    else {
                        hasil = "Low risk"
                    }
                }
                else if low >= 6 {
                    hasil = "Low risk"
                }
            }
        }
        
        return hasil
    }
}
