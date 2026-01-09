//
//  Buku.swift
//  library-app
//
//  Created by Valencia Melita Christy on 09/01/26.
//

import Foundation

struct Buku: Identifiable, Codable {
    let id: UUID
    let judulBuku: String
    let namaPenulis: String
    let status: String
    let coverUrl: String?
    let tahunTerbit: Int

    enum CodingKeys: String, CodingKey {
        case id = "id_buku"
        case judulBuku = "judul_buku"
        case namaPenulis = "nama_penulis"
        case status
        case coverUrl = "cover_url"
        case tahunTerbit = "tahun_terbit"
    }
}
