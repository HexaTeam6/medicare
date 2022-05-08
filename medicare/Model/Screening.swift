//
//  Screening.swift
//  medicare
//
//  Created by Abdur Rachman Wahed on 06/05/22.
//

import Foundation

struct Input: Decodable, Identifiable, Hashable {
    var id: String = UUID().uuidString
    var option: String = String()
}

struct Screening: Identifiable{
    var id: String = UUID().uuidString
    var pertanyaan: String
    var jenisInput: String
    var input: [Input] = [Input]()
}

extension Screening{
    static var sampleData = [
        Screening(pertanyaan: "Gender", jenisInput: "Option", input: [
            Input(option: "Male"),
            Input(option: "Female")]),
        Screening(pertanyaan: "Born Date", jenisInput: "Date"),
        Screening(pertanyaan: "Height", jenisInput: "Number"),
        Screening(pertanyaan: "Weight", jenisInput: "Number"),
        Screening(pertanyaan: "Waist size", jenisInput: "Number"),
        Screening(pertanyaan: "Do you often do physical activities?", jenisInput: "Option", input: [
            Input(option: "Yes"),
            Input(option: "No"),
            Input(option: "Seldom")]),
        Screening(pertanyaan: "Do you smoke?", jenisInput: "Option", input: [
            Input(option: "Yes"),
            Input(option: "Trying to quit smoking"),
            Input(option: "No")]),
        Screening(pertanyaan: "How often do you eat fruits and vegetables", jenisInput: "Option", input: [
            Input(option: "Everyday"),
            Input(option: "Not Everyday")]),
        Screening(pertanyaan: "Are you taking anti-hypertensive drugs regularly?", jenisInput: "Option", input: [
            Input(option: "Yes"),
            Input(option: "No")]),
        Screening(pertanyaan: "Have you ever had high blood pressure?", jenisInput: "Option", input: [
            Input(option: "Yes"),
            Input(option: "No")]),
        Screening(pertanyaan: "Do you suffer from heartbeat disorders?", jenisInput: "Option", input: [
            Input(option: "Yes"),
            Input(option: "No"),
            Input(option: "Not Sure")]),
        Screening(pertanyaan: "Have you ever experienced an increase in blood sugar levels? (when pregnant, sick, or when blood sugar checkup)", jenisInput: "Option", input: [
            Input(option: "Yes"),
            Input(option: "No")]),
        Screening(pertanyaan: "Your current blood pressure", jenisInput: "Option", input: [
            Input(option: "> 140/90"),
            Input(option: "120-139 / 80-89"),
            Input(option: "< 120/80"),
            Input(option: "Not sure")]),
        Screening(pertanyaan: "Your current blood sugar", jenisInput: "Option", input: [
            Input(option: "< 120"),
            Input(option: "120 - 150"),
            Input(option: "> 150"),
            Input(option: "Not sure")]),
        Screening(pertanyaan: "Your current cholesterol level (mmol/L)", jenisInput: "Option", input: [
            Input(option: "> 240"),
            Input(option: "200 - 239"),
            Input(option: "< 200"),
            Input(option: "Not sure")]),
        Screening(pertanyaan: "Your current healthy cholesterol levels (mmol/L)", jenisInput: "Option", input: [
            Input(option: "< 30"),
            Input(option: "30 - 50"),
            Input(option: "> 50"),
            Input(option: "Not sure")]),
        Screening(pertanyaan: "Does your family have a history of stroke?", jenisInput: "Option", input: [
            Input(option: "Yes"),
            Input(option: "No"),
            Input(option: "Not sure")]),
        Screening(pertanyaan: "Have a family member or relative ever vdiagnosed with diabetes?", jenisInput: "Option", input: [
            Input(option: "No"),
            Input(option: "Yes (Grandfather/Grandmother, Aunt, Uncle, or cousins)"),
            Input(option: "Yes (Parents, Brothers, Sisters or Biological Child)")])
    ]
}
