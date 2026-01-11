//
//  Formatter.swift
//  library-app
//
//  Created by Valencia Melita Christy on 10/01/26.
//

import Foundation

// Digunakan untuk menampilkan tanggal ke UI, Locale POSIX untuk memastikan parsing konsisten, dan tidak terpengaruh pengaturan perangkat (dateFormatter + format:)
let dateFormatter: DateFormatter = {
    let f = DateFormatter()
    f.dateFormat = "yyyy-MM-dd"
    f.locale = Locale(identifier: "en_US_POSIX")
    return f
}()


func format(_ date: Date) -> String {
    dateFormatter.string(from: date)
}

// Membuat JSONDecoder dengan strategi decoding tanggal khusus
// Digunakan untuk menangani berbagai format tanggal dari Supabase
func makeJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()

    let dateOnly = DateFormatter()
    dateOnly.dateFormat = "yyyy-MM-dd"
    dateOnly.locale = .init(identifier: "en_US_POSIX")

    let tsNoFraction = DateFormatter()
    tsNoFraction.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
    tsNoFraction.locale = .init(identifier: "en_US_POSIX")

    let tsWithFraction = DateFormatter()
    tsWithFraction.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS"
    tsWithFraction.locale = .init(identifier: "en_US_POSIX")

    decoder.dateDecodingStrategy = .custom { decoder in
        let container = try decoder.singleValueContainer()
        let value = try container.decode(String.self)

        if let date = tsWithFraction.date(from: value) {
            return date
        }

        if let date = tsNoFraction.date(from: value) {
            return date
        }

        if let date = dateOnly.date(from: value) {
            return date
        }

        throw DecodingError.dataCorruptedError(
            in: container,
            debugDescription: "Unsupported date format: \(value)"
        )
    }
    return decoder
}



