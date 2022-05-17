//
//  Diabetes.swift
//  medicare
//
//  Created by Abdur Rachman Wahed on 17/05/22.
//

import Foundation

// MARK: Calculate Diabetes
func calcDiabetes(userAnswer: [Answer]) -> HasilRisiko {
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
    
    if score >= 15 { return HasilRisiko(risiko: "High risk", score: Double(score)) }
    else if score >= 12 { return HasilRisiko(risiko: "Medium risk", score: Double(score)) }
    else { return HasilRisiko(risiko: "Low risk", score: Double(score)) }
}
