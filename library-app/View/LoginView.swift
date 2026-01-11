//
//  LoginView.swift
//  library-app
//
//  Created by Valencia Melita Christy on 09/01/26.
//

import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = LoginViewModel()
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            ZStack {
                VStack(spacing: 24) {
                    // Title
                    Text("Login Admin")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.black)

                    VStack(spacing: 16) {

                        // Username
                        HStack {
                            Image(systemName: "person")
                                .foregroundColor(.gray)

                            TextField("Username", text: $viewModel.username)
                                .autocapitalization(.none)
                        }
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)

                        //Password
                        HStack {
                            Image(systemName: "lock")
                                .foregroundColor(.gray)

                            SecureField("Password", text: $viewModel.password)
                        }
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        if let error = viewModel.errorMessage {
                            Text(error)
                                .foregroundColor(.red)
                                .font(.caption)
                        }

                        // Button
                        Button {
                            Task {
                                await viewModel.login()
                            }
                        } label: {
                            if viewModel.isLoading {
                                ProgressView()
                            } else {
                                Text("Login")
                                    .frame(maxWidth: .infinity)
                            }
                        }
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .disabled(
                            viewModel.username.isEmpty
                                || viewModel.password.isEmpty
                                || viewModel.isLoading
                        )
                    }
                    .padding()
                    .background(.white)
                    .cornerRadius(16)
                    .shadow(radius: 10)

                    Spacer()
                }
                .padding()
                .navigationDestination(isPresented: $viewModel.isAuthenticated)
                {
                        ManagementView()
                }
            }
        }
    }
}

#Preview {
    LoginView()
}
