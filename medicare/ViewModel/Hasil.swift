//
//  Hasil.swift
//  medicare
//
//  Created by Abdur Rachman Wahed on 17/05/22.
//

import Foundation
import CoreData

// MARK: Add Hasil
func addHasil(viewContext: NSManagedObjectContext, userAnswer: [Answer]){
    let newHasil = Hasil(context: viewContext)
    
    let hasilDiabetes = calcDiabetes(userAnswer: userAnswer)
    let hasiKolesterol = calcKolesterol(userAnswer: userAnswer)
    let hasilStroke = calcStroke(userAnswer: userAnswer)
    
    newHasil.id = UUID()
    
    newHasil.hasilDiabetes = hasilDiabetes.risiko
    newHasil.scoreDiabetes = Int16(hasilDiabetes.score)
    
    newHasil.hasilKolesterol = hasiKolesterol.risiko
    newHasil.scoreKolesterol = hasiKolesterol.score
    
    newHasil.hasilStroke = hasilStroke.risiko
    newHasil.scoreStroke = Int16(hasilStroke.score)
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd MMM, yyyy"
    
    newHasil.tglScreening = dateFormatter.string(from: Date())
    newHasil.created_at = Date()
    
    do {
        try viewContext.save()
    } catch {
        print("Tidak bisa disimpan")
    }
}
