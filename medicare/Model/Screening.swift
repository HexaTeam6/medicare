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
        Screening(pertanyaan: "Jenis kelamin", jenisInput: "Option", input: [
            Input(option: "Laki-laki"),
            Input(option: "Perempuan")]),
        Screening(pertanyaan: "Tanggal lahir", jenisInput: "Date"),
        Screening(pertanyaan: "Tinggi badan", jenisInput: "Number"),
        Screening(pertanyaan: "Berat badan", jenisInput: "Number"),
        Screening(pertanyaan: "Ukuran lingkar pinggang", jenisInput: "Number"),
        Screening(pertanyaan: "Apakah anda aktif melakukan aktivitas fisik?", jenisInput: "Option", input: [
            Input(option: "Ya"),
            Input(option: "Tidak"),
            Input(option: "Jarang")]),
        Screening(pertanyaan: "Apakah anda merokok?", jenisInput: "Option", input: [
            Input(option: "Perokok aktif"),
            Input(option: "Sedang berusaha berhenti merokok"),
            Input(option: "Tidak merokok")]),
        Screening(pertanyaan: "Seberapa sering anda makan ayuran atau buah buahan?", jenisInput: "Option", input: [
            Input(option: "Setiap hari"),
            Input(option: "Tidak setiap hari")]),
        Screening(pertanyaan: "Apakah mengonsumsi obat anti hipertensi secara reguler?", jenisInput: "Option", input: [
            Input(option: "Ya"),
            Input(option: "Tidak")]),
        Screening(pertanyaan: "Apakah anda pernah mengalami tekanan darat tinggi?", jenisInput: "Option", input: [
            Input(option: "Ya"),
            Input(option: "Tidak")]),
        Screening(pertanyaan: "Apakah anda menderita gangguan irama jantung?", jenisInput: "Option", input: [
            Input(option: "Ya"),
            Input(option: "Tidak pernah"),
            Input(option: "Tidak diketahui")]),
        Screening(pertanyaan: "Apakah anda pernah mengalami peningkatan kadar gula darah? (saat hamil, sakit, pemeriksaan gula darah)", jenisInput: "Option", input: [
            Input(option: "Ya"),
            Input(option: "Tidak")]),
        Screening(pertanyaan: "Tekanan darah anda saat ini", jenisInput: "Option", input: [
            Input(option: "> 140/90"),
            Input(option: "120-139 / 80-89"),
            Input(option: "< 120/80"),
            Input(option: "Tidak diketahui")]),
        Screening(pertanyaan: "Kadar gula anda saat ini", jenisInput: "Option", input: [
            Input(option: "< 120"),
            Input(option: "120 - 150"),
            Input(option: "> 150"),
            Input(option: "Tidak diketahui")]),
        Screening(pertanyaan: "Kadar kolesterol anda saat ini (mmol/L)", jenisInput: "Option", input: [
            Input(option: "> 240"),
            Input(option: "200 - 239"),
            Input(option: "< 200"),
            Input(option: "Tidak diketahui")]),
        Screening(pertanyaan: "Kadar kolesterol sehat (HDL) anda saat ini (mmol/L)", jenisInput: "Option", input: [
            Input(option: "< 30"),
            Input(option: "30 - 50"),
            Input(option: "> 50"),
            Input(option: "Tidak diketahui")]),
        Screening(pertanyaan: "Apakah keluarga memiliki riwayat stroke?", jenisInput: "Option", input: [
            Input(option: "Ya"),
            Input(option: "Tidak"),
            Input(option: "Tidak diketahui")]),
        Screening(pertanyaan: "Apakah memiliki anggota keluarga atau saudara yang ter-diagnosa diabetes?", jenisInput: "Option", input: [
            Input(option: "Tidak"),
            Input(option: "Ya (Kakek/Nenek, Bibi, Paman, atau sepupu dekat)"),
            Input(option: "Ya (Orang tua, Kakak, Adik, atau Anak kandung)")])
    ]
}
