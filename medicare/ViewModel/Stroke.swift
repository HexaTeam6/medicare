//
//  Stroke.swift
//  medicare
//
//  Created by Abdur Rachman Wahed on 17/05/22.
//

import Foundation


// MARK: Calculate Stroke
func calcStroke (userAnswer: [Answer]) -> HasilRisiko {
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
    
    return HasilRisiko(risiko: hasil, score: Double(0))
}
