//
//  ReusableComponents.swift
//  library-app
//
//  Created by Valencia Melita Christy on 10/01/26.
//

import SwiftUI

func statusColor(_ status: String) -> Color {
    switch status.lowercased() {
    case "tersedia":
        return .green
    case "tidak tersedia":
        return .red
    default:
        return .gray
    }
}

