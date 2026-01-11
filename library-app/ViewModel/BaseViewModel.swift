//
//  BaseViewModel.swift
//  library-app
//
//  Created by Valencia Melita Christy on 10/01/26.
//

import Combine

// Penerapan OOP (Inheritance & Polymorphism)
class BaseViewModel: ObservableObject {
    // Inheritance -- menurunkan sifat" ke ViewModel yang memakai BaseViewModel
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    // Polymorphism -- menyederhanakan fetch di semua viewModel
    func load() async {}
}


