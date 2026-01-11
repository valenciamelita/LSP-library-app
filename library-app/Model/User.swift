//
//  User.swift
//  library-app
//
//  Created by Valencia Melita Christy on 09/01/26.
//

// Model data untuk merepresentasikan pengguna aplikasi (admin)
import Foundation

struct User: Identifiable, Codable {
    let id: UUID
    let username: String

    // Mapping nama properti Swift ke nama kolom database / JSON
    enum CodingKeys: String, CodingKey {
        case id = "id_user"
        case username
    }
}
