//
//  Peminjaman.swift
//  library-app
//
//  Created by Valencia Melita Christy on 09/01/26.
//

import Foundation

struct Peminjaman: Identifiable, Codable {
    let id: UUID
    let idBuku: UUID
    let idPeminjam: UUID
    let tanggalPinjam: Date
    let tanggalKembali: Date
    let tanggalDikembalikan: Date?
    let createdAt: Date

    enum CodingKeys: String, CodingKey {
        case id = "id_peminjaman"
        case idBuku = "id_buku"
        case idPeminjam = "id_peminjam"
        case tanggalPinjam = "tanggal_pinjam"
        case tanggalKembali = "tanggal_kembali"
        case tanggalDikembalikan = "tanggal_dikembalikan"
        case createdAt = "created_at"
    }
}
