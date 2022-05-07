//
//  HasilScreening.swift
//  medicare
//
//  Created by Abdur Rachman Wahed on 07/05/22.
//

import Foundation

struct HasilScreening: Identifiable{
    var id: String = UUID().uuidString
    var hasilDiabetes: String = "Belum screening"
    var hasilKolesterol: String = "Belum screening"
    var hasilStroke: String = "Belum screening"
    var tglScreening: String = ""
}
