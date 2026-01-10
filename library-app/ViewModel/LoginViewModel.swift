//
//  LoginViewModel.swift
//  library-app
//
//  Created by Valencia Melita Christy on 10/01/26.
//

import Foundation
import Supabase
import Combine

@MainActor
class LoginViewModel: ObservableObject {

    @Published var username: String = ""
    @Published var password: String = ""

    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var isAuthenticated: Bool = false

    func login() async {
        isLoading = true
        errorMessage = nil
        defer { isLoading = false }

        do {
            _ = try await supabase
                .rpc("login_user", params: [
                    "p_username": username,
                    "p_password": password
                ])
                .execute()

            isAuthenticated = true

        } catch {
            errorMessage = "Username atau password salah"
            isAuthenticated = false
        }
    }
}

