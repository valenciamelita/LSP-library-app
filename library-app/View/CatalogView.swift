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
                    // ViewModel ambil data
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
                    //Kalau belum ada buku
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
                    // Kalau ada buku
                    else {
                        ScrollView {
                            let columns = [
                                GridItem(.flexible(), spacing: 16),
                                GridItem(.flexible(), spacing: 16)
                            ]

                            LazyVGrid(columns: columns, spacing: 16) {
                                ForEach(viewModel.bukuList) { buku in
                                    VStack(alignment: .leading, spacing: 8) {
                                        // Card buku
                                        ZStack(alignment: .topTrailing) {

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
                                            .frame(maxHeight: 250)
                                            .frame(maxWidth: 160)
                                            .clipped()
                                            .cornerRadius(10)

                                            Text(buku.status.capitalized)
                                                .font(.caption2)
                                                .fontWeight(.semibold)
                                                .padding(.horizontal, 10)
                                                .padding(.vertical, 4)
                                                .background(statusColor(buku.status))
                                                .foregroundColor(.white)
                                                .clipShape(Capsule())
                                                .padding(8)
                                        }

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
                        // Pull to refresh
                        .refreshable {
                            await viewModel.load()
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
            // Load data katalog saat view pertama muncul
            .task {
                await viewModel.load()
            }
        }
}

#Preview {
    CatalogView()
}
