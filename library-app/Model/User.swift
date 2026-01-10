//
//  User.swift
//  library-app
//
//  Created by Valencia Melita Christy on 09/01/26.
//

import Foundation

struct User: Identifiable, Codable {
    let id: UUID
    let username: String

    enum CodingKeys: String, CodingKey {
        case id = "id_user"
        case username
    }
}
