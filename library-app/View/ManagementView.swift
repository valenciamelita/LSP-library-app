//
//  ManagementView.swift
//  library-app
//
//  Created by Valencia Melita Christy on 10/01/26.
//

import SwiftUI

struct ManagementView: View {
    @StateObject private var viewModel = ManagementViewModel()
    
    var body: some View {
        NavigationStack {
            Group {
                if viewModel.isLoading {
                    ProgressView("Memuat data peminjaman...")
                }
                else if let error = viewModel.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                        .padding()
                }
                else if viewModel.peminjamanList.isEmpty {
                    Text("Belum ada data peminjaman")
                        .foregroundColor(.secondary)
                }
                else {
                    ScrollView {
                        LazyVStack(spacing: 12) {
                            ForEach(viewModel.peminjamanList) { peminjaman in
                                HStack(alignment: .top, spacing: 12) {

                                    AsyncImage(url: URL(string: peminjaman.buku?.coverUrl ?? "")) { image in
                                        image
                                            .resizable()
                                            .scaledToFill()
                                    } placeholder: {
                                        Image(systemName: "book.closed")
                                            .resizable()
                                            .scaledToFit()
                                            .foregroundColor(.secondary)
                                            .padding(6)
                                    }
                                    .frame(width: 50, height: 70)
                                    .clipped()
                                    .cornerRadius(6)

                                    // 📄 INFO
                                    VStack(alignment: .leading, spacing: 6) {

                                        // Judul buku
                                        Text(peminjaman.buku?.judul ?? "Judul tidak tersedia")
                                            .font(.headline)
                                            .lineLimit(2)

                                        // Nama peminjam
                                        Text("Peminjam: \(peminjaman.namaPeminjam ?? "Unknown")")
                                            .font(.subheadline)
                                            .foregroundColor(.secondary)

                                        Text("Pinjam: \(format(peminjaman.tanggalPinjam))")
                                            .font(.caption)

                                        Text("Harus kembali: \(format(peminjaman.tanggalKembali))")
                                            .font(.caption)

                                        if let dikembalikan = peminjaman.tanggalDikembalikan {
                                            Text("Dikembalikan: \(format(dikembalikan))")
                                                .font(.caption)
                                                .foregroundColor(.green)
                                        } else {
                                            Text("Status: Belum dikembalikan")
                                                .font(.caption)
                                                .foregroundColor(.orange)

                                            Button("Tandai Dikembalikan") {
                                                Task {
                                                    await viewModel.markAsReturned(
                                                        peminjaman: peminjaman
                                                    )
                                                }
                                            }
                                            .buttonStyle(.borderedProminent)
                                            .padding(.top, 4)
                                        }
                                    }

                                    Spacer()
                                }
                                .padding(12)
                                .background(Color(.systemBackground))
                                .cornerRadius(12)
                                .shadow(radius: 1)
                            }
                        }
                        .padding()
                    }
                    .refreshable(action: viewModel.fetchPeminjaman)
                }

            }
            .navigationTitle("Peminjaman")
            .task {
                await viewModel.load()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
                        AddPeminjamanView()
                    } label: {
                        Image(systemName: "plus")
                            .foregroundStyle(Color(.blue))
                    }
                }
            }
        }
    }
}
#Preview {
    ManagementView()
}
