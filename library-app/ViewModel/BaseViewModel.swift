//
//  BaseViewModel.swift
//  library-app
//
//  Created by Valencia Melita Christy on 10/01/26.
//

import Combine


class BaseViewModel: ObservableObject {
    // Inheritance
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    // Polymorphism
    func load() async {}
}


