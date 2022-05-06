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
    var nilai: Int = Int()
}

struct Screening: Identifiable{
    var id: String = UUID().uuidString
    var pertanyaan: String
    var jenisInput: String
    var input: [Input] = [Input]()
}


#if DEBUG
extension Screening{
    static var sampleData = [
        Screening(pertanyaan: "Jenis kelamin", jenisInput: "Option", input: [
            Input(option: "Laki-laki", nilai: 1),
            Input(option: "Perempuan", nilai: 2)]),
        Screening(pertanyaan: "Tanggal lahir", jenisInput: "Date"),
        Screening(pertanyaan: "Tinggi badan", jenisInput: "Number"),
        Screening(pertanyaan: "Berat badan", jenisInput: "Number"),
        Screening(pertanyaan: "Apakah anda aktif melakukan aktivitas fisik?", jenisInput: "Option", input: [
            Input(option: "Ya", nilai: 1),
            Input(option: "Tidak", nilai: 1),
            Input(option: "Jarang", nilai: 1)]),
        Screening(pertanyaan: "Apakah anda merokok?", jenisInput: "Option", input: [
            Input(option: "Perokok aktif", nilai: 1),
            Input(option: "Sedang berusaha berhenti merokok", nilai: 1),
            Input(option: "Tidak merokok", nilai: 1)]),
        Screening(pertanyaan: "Ukuran lingkar pinggang", jenisInput: "Number"),
        Screening(pertanyaan: "Apakah anda pernah mengalami tekanan darat tinggi?", jenisInput: "Option", input: [
            Input(option: "Ya", nilai: 1),
            Input(option: "Tidak", nilai: 1)]),
        Screening(pertanyaan: "Tekanan darah anda saat ini", jenisInput: "Option", input: [
            Input(option: "> 140/90", nilai: 1),
            Input(option: "120-139 / 80-89", nilai: 1),
            Input(option: "< 120/80", nilai: 1),
            Input(option: "Tidak diketahui", nilai: 1)]),
        Screening(pertanyaan: "Apakah anda pernah mengalami peningkatan kadar gula darah? (saat hamil, sakit, pemeriksaan gula darah)", jenisInput: "Option", input: [
            Input(option: "Ya", nilai: 1),
            Input(option: "Tidak", nilai: 1)]),
        Screening(pertanyaan: "Kadar gula anda saat ini", jenisInput: "Option", input: [
            Input(option: "< 120", nilai: 1),
            Input(option: "120 - 150", nilai: 1),
            Input(option: "> 150", nilai: 1),
            Input(option: "Tidak diketahui", nilai: 1)]),
        Screening(pertanyaan: "Kadar kolesterol anda saat ini (mmol/L)", jenisInput: "Option", input: [
            Input(option: "> 240", nilai: 1),
            Input(option: "200 - 239", nilai: 1),
            Input(option: "< 200", nilai: 1),
            Input(option: "Tidak diketahui", nilai: 1)]),
        Screening(pertanyaan: "Apakah keluarga memiliki riwayat stroke?", jenisInput: "Option", input: [
            Input(option: "Ya", nilai: 1),
            Input(option: "Tidak", nilai: 1),
            Input(option: "Tidak diketahui", nilai: 1)]),
        Screening(pertanyaan: "Apakah anda menderita gangguan irama jantung?", jenisInput: "Option", input: [
            Input(option: "Ya", nilai: 1),
            Input(option: "Tidak pernah", nilai: 1),
            Input(option: "Tidak diketahui", nilai: 1)]),
        Screening(pertanyaan: "Seberapa sering anda makan ayuran atau buah buahan?", jenisInput: "Option", input: [
            Input(option: "Setiap hari", nilai: 1),
            Input(option: "Tidak setiap hari", nilai: 1)]),
        Screening(pertanyaan: "Apakah mengonsumsi obat anti hipertensi secara reguler?", jenisInput: "Option", input: [
            Input(option: "Tidak", nilai: 1),
            Input(option: "Ya", nilai: 1)]),
        Screening(pertanyaan: "Apakah memiliki anggota keluarga atau saudara yang ter-diagnosa diabetes?", jenisInput: "Option", input: [
            Input(option: "Tidak", nilai: 1),
            Input(option: "Ya (Kakek/Nenek, Bibi, Paman, atau sepupu dekat)", nilai: 1),
            Input(option: "Ya (Orang tua, Kakak, Adik, atau Anak kandung)", nilai: 1)]),
        Screening(pertanyaan: "Kadar kolesterol sehat (HDL) anda saat ini (mmol/L)", jenisInput: "Option", input: [
            Input(option: "< 30", nilai: 1),
            Input(option: "30 - 50", nilai: 1),
            Input(option: "> 50", nilai: 1),
            Input(option: "Tidak diketahui", nilai: 1)]),
    ]
}
#endif
