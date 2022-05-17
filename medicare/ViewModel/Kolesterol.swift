//
//  Kolesterol.swift
//  medicare
//
//  Created by Abdur Rachman Wahed on 17/05/22.
//

import Foundation

// MARK: Calculate Kolesterol
func calcKolesterol(userAnswer: [Answer]) -> HasilRisiko {
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
        return HasilRisiko(risiko: "No risk", score: 0)
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
    
    return HasilRisiko(risiko: hasil, score: kolesterol_res)
}
