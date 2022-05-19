//
//  HasilScreening.swift
//  medicare
//
//  Created by Abdur Rachman Wahed on 19/05/22.
//

import Foundation

struct HasilScreening: Identifiable, Codable {
    var id = UUID()
    var hasiDiabetes: String = "Not screened yet"
    var hasilKolesterol: String = "Not Screened yet"
    var hasilStroke: String = "Not Screened yet"
    var tglScreening: String = ""
}
