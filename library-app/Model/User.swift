//
//  User.swift
//  library-app
//
//  Created by Valencia Melita Christy on 09/01/26.
//

import Foundation

struct User: Identifiable, Codable {
    let id: UUID
    let namaUser: String
    let username: String
    let password: String
    let role: String

    enum CodingKeys: String, CodingKey {
        case id = "id_user"
        case namaUser = "nama_user"
        case username
        case password
        case role
    }
}
