//
//  Formatter.swift
//  library-app
//
//  Created by Valencia Melita Christy on 10/01/26.
//

import Foundation

let dateFormatter: DateFormatter = {
    let f = DateFormatter()
    f.dateFormat = "yyyy-MM-dd"
    f.locale = Locale(identifier: "en_US_POSIX")
    return f
}()

func format(_ date: Date) -> String {
    dateFormatter.string(from: date)
}

func makeJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .formatted(dateFormatter)
    return decoder
}

