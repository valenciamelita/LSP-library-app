//
//  CatalogViewModel.swift
//  library-app
//
//  Created by Valencia Melita Christy on 09/01/26.
//

import Foundation
import Supabase
import Combine

@MainActor
class CatalogViewModel: ObservableObject {

    // MARK: - State
    @Published var bukuList: [Buku] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    // MARK: - Fetch Catalog
    func fetchCatalog() async {
        isLoading = true
        errorMessage = nil
        defer { isLoading = false }

        do {
            let response = try await supabase
                .from("buku")
                .select()
                .order("judul_buku", ascending: true)
                .execute()

            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601

            bukuList = try decoder.decode([Buku].self, from: response.data)
        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }
}
