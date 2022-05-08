//
//  HasilScreening.swift
//  medicare
//
//  Created by Abdur Rachman Wahed on 07/05/22.
//

import Foundation

struct HasilScreening: Identifiable{
    var id: String = UUID().uuidString
    var hasilDiabetes: String = "Not screened yet"
    var hasilKolesterol: String = "Not screened yet"
    var hasilStroke: String = "Not screened yet"
    var tglScreening: String = ""
}
