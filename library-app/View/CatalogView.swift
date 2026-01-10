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
                        ScrollView {
                            let columns = [
                                GridItem(.flexible(), spacing: 16),
                                GridItem(.flexible(), spacing: 16)
                            ]

                            LazyVGrid(columns: columns, spacing: 16) {
                                ForEach(viewModel.bukuList) { buku in
                                    VStack(alignment: .leading, spacing: 8) {

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
                                        .frame(height: 160)
                                        .frame(maxWidth: .infinity)
                                        .clipped()
                                        .cornerRadius(10)

                                        Text(buku.judulBuku)
                                            .font(.headline)
                                            .lineLimit(2)

                                        Text(buku.namaPenulis)
                                            .font(.subheadline)
                                            .foregroundColor(.secondary)
                                            .lineLimit(1)

                                        Text(String(buku.tahunTerbit))
                                            .font(.caption)
                                            .foregroundColor(.secondary)
                                    }
                                    .padding(10)
                                    .background(Color(.systemBackground))
                                    .cornerRadius(12)
                                    .shadow(radius: 2)
                                }
                            }
                            .padding()
                        }
                    }

                }
                .navigationTitle("Katalog Buku")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink {
                            LoginView()
                        } label: {
                            Text("Login Admin")
                                .foregroundStyle(Color(.blue))
                        }
                    }
                }
            }
            .task {
                await viewModel.fetchCatalog()
            }
        }
}

#Preview {
    CatalogView()
}
