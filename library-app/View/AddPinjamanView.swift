//
//  AddPinjamanView.swift
//  library-app
//
//  Created by Valencia Melita Christy on 10/01/26.
//

import SwiftUI

struct AddPeminjamanView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel = AddPeminjamanViewModel()
    
    // Menyimpan ID buku yang dipilih dari Picker
    @State private var selectedBukuID: UUID? = nil

    var body: some View {
        NavigationStack {
            Form {
                // Nama Peminjam
                Section(header: Text("Data Peminjam")) {
                    TextField("Nama Peminjam", text: $viewModel.namaPeminjam)
                }
                
                // Pilih Buku
                Section(header: Text("Buku")) {
                    if viewModel.bukuList.isEmpty {
                        Text("Tidak ada buku tersedia")
                            .foregroundColor(.secondary)
                    } else {
                        Picker("Pilih Buku", selection: $selectedBukuID) {
                            Text("— Pilih Buku —")
                                .tag(UUID?.none)

                            ForEach(viewModel.bukuList) { buku in
                                Text(buku.judulBuku)
                                    .tag(Optional(buku.id))
                            }
                        }
                    }
                }
                // Tanggal Pinjam (hari ini)
                Section(header: Text("Tanggal")) {
                    HStack {
                        Text("Tanggal Pinjam")
                        Spacer()
                        Text(dateFormatter.string(from: Date()))
                            .foregroundColor(.secondary)
                    }

                    // Tanggal kembali (hasil hitung)
                    HStack {
                        Text("Tanggal Kembali")
                        Spacer()
                        Text(
                            dateFormatter.string(
                                from: Calendar.current.date(
                                    byAdding: .day,
                                    value: 7,
                                    to: Date()
                                )!
                            )
                        )
                        .foregroundColor(.secondary)
                    }
                }
                // Error handling
                if let error = viewModel.errorMessage {
                    Section {
                        Text(error)
                            .foregroundColor(.red)
                    }
                }
                // Button Simpan
                Section {
                    Button {
                        Task {
                            await viewModel.submit()
                        }
                    } label: {
                        HStack {
                            Spacer()
                            if viewModel.isLoading {
                                ProgressView()
                            } else {
                                Text("Simpan Peminjaman")
                            }
                            Spacer()
                        }
                    }
                    .padding(.vertical, 8)
                    .foregroundColor(.white)
                    .listRowBackground(
                        (viewModel.namaPeminjam.isEmpty || viewModel.selectedBuku == nil)
                        ? Color.gray
                        : Color.blue
                    )
                    .disabled(
                        viewModel.namaPeminjam.isEmpty ||
                        viewModel.selectedBuku == nil ||
                        viewModel.isLoading
                    )
                }
            }
            .navigationTitle("Tambah Peminjaman")
            .navigationBarTitleDisplayMode(.inline)
            
            // Load data buku saat view muncul
            .task {
                await viewModel.load()
                selectedBukuID = viewModel.selectedBuku?.id
            }
            
            // Sinkronisasi pilihan buku dengan ViewModel
            .onChange(of: selectedBukuID) { _, newID in
                if let id = newID {
                    viewModel.selectedBuku = viewModel.bukuList.first { $0.id == id }
                } else {
                    viewModel.selectedBuku = nil
                }
            }
            
            // Tutup view jika penyimpanan berhasil
            .onChange(of: viewModel.isSuccess) { _, success in
                if success {
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    AddPeminjamanView()
}
