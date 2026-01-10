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
class LoginViewModel: BaseViewModel {

    @Published var username: String = ""
    @Published var password: String = ""
    @Published var isAuthenticated: Bool = false

    func login() async {
        isLoading = true
        errorMessage = nil
        defer { isLoading = false }

        do {
            let response = try await supabase
                .rpc("login_user", params: [
                    "p_username": username,
                    "p_password": password
                ])
                .execute()

            let users = try JSONDecoder().decode([User].self, from: response.data)

            if !users.isEmpty {
                isAuthenticated = true
            } else {
                errorMessage = "Username atau password salah"
            }

        } catch {
            print(error)
        }
    }

}

