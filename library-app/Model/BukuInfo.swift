//
//  BukuInfo.swift
//  library-app
//
//  Created by Valencia Melita Christy on 10/01/26.
//

// Model data ringkas untuk informasi buku, digunakan untuk relasi pada Peminjaman
struct BukuInfo: Codable {
    let judul: String
    let coverUrl: String?

    // Mapping nama properti Swift ke nama kolom database / JSON
    enum CodingKeys: String, CodingKey {
        case judul = "judul_buku"
        case coverUrl = "cover_url"
    }
}
