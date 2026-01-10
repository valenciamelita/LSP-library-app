//
//  Peminjaman.swift
//  library-app
//
//  Created by Valencia Melita Christy on 09/01/26.
//

import Foundation

struct Peminjaman: Identifiable, Codable {
    let id: UUID
    let tanggalPinjam: Date
    let tanggalKembali: Date
    let tanggalDikembalikan: Date?
    let namaPeminjam: String?
    let createdAt: Date
    let buku: BukuInfo?

    enum CodingKeys: String, CodingKey {
        case id = "id_peminjaman"
        case tanggalPinjam = "tanggal_pinjam"
        case tanggalKembali = "tanggal_kembali"
        case tanggalDikembalikan = "tanggal_dikembalikan"
        case namaPeminjam = "nama_peminjam"
        case createdAt = "created_at"
        case buku
    }
}
