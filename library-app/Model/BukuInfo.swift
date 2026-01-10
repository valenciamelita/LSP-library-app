//
//  BukuInfo.swift
//  library-app
//
//  Created by Valencia Melita Christy on 10/01/26.
//

struct BukuInfo: Codable {
    let judul: String
    let coverUrl: String?

    enum CodingKeys: String, CodingKey {
        case judul = "judul_buku"
        case coverUrl = "cover_url"
    }
}
