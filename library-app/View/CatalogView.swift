//
//  CatalogView.swift
//  library-app
//
//  Created by Valencia Melita Christy on 09/01/26.
//

import SwiftUI
import Foundation
import Supabase

struct CatalogView: View {
    @StateObject private var viewModel = CatalogViewModel()
    
    var body: some View {
            NavigationStack {
                Group {
                    if viewModel.isLoading {
                        ProgressView("Loading katalog...")
                    } else if let error = viewModel.errorMessage {
                        VStack(spacing: 12) {
                            Text("Terjadi kesalahan")
                                .font(.headline)
                            Text(error)
                                .font(.caption)
                                .foregroundColor(.red)
                        }
                    }  else if viewModel.bukuList.isEmpty {
                        VStack(spacing: 8) {
                            Image(systemName: "book.closed")
                                .font(.system(size: 40))
                                .foregroundColor(.secondary)
                            
                            Text("Belum ada buku")
                                .font(.headline)
                                .foregroundColor(.secondary)
                        }
                    }
                    else {
                        List(viewModel.bukuList) { buku in
                            VStack(alignment: .leading) {
                                AsyncImage(url: URL(string: buku.coverUrl ?? "")) { image in
                                            image
                                                .resizable()
                                                .scaledToFill()
                                        } placeholder: {
                                            Image(systemName: "book.closed")
                                                .resizable()
                                                .scaledToFit()
                                                .foregroundColor(.secondary)
                                        }
                                        .frame(width: 100, height: 150)   // ⬅️ KECIL & PROPORSIONAL
                                        .clipped()
                                        .cornerRadius(6)
                                Text(buku.judulBuku)
                                    .font(.headline)

                                Text(buku.namaPenulis)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)

                                Text(String( buku.tahunTerbit))
                                    .font(.caption)
                            }
                            .padding(8)
                        }
                    }
                }
                .navigationTitle("Katalog Buku")
            }
            .task {
                await viewModel.fetchCatalog()
            }
        }
}

#Preview {
    CatalogView()
}
