//
//  AddPeminjamanViewModel.swift
//  library-app
//
//  Created by Valencia Melita Christy on 10/01/26.
//

import Foundation
import Supabase
import Combine

@MainActor
class AddPeminjamanViewModel: BaseViewModel {

    @Published var namaPeminjam: String = ""
    @Published var selectedBuku: Buku?
    @Published var tanggalPinjam: Date = Date()
    @Published var bukuList: [Buku] = []
    
    @Published var isSuccess = false
    
    // Polymorphism
    override func load() async {
          await fetchBukuTersedia()
      }

    // Mengambil daftar buku dengan status "tersedia"
    func fetchBukuTersedia() async {
        do {
            // Ambil tabel buku, select semua yang statusnya tersedia, order by judul_buku asc)
            let response = try await supabase
                .from("buku")
                .select()
                .eq("status", value: "tersedia")
                .order("judul_buku", ascending: true)
                .execute()

            // Decode JSON ke model
            bukuList = try makeJSONDecoder().decode(
                [Buku].self,
                from: response.data
            )
        } catch {
            errorMessage = error.localizedDescription
        }
    }

    // Menyimpan data peminjaman ke database
    func submit() async {
        // Kalau tidak ada buku yg dipilih, error message keluar
        guard let buku = selectedBuku else {
            errorMessage = "Buku harus dipilih"
            return
        }
        
        isLoading = true
        errorMessage = nil

        do {
            // Tanggal kembali dari curr date + 7 hr
            let tanggalKembali = Calendar.current.date(
                byAdding: .day,
                value: 7,
                to: tanggalPinjam
            )!
            
            // Insert ke peminjaman, value sesuai id buku, nama, tanggal pinjam dan kembali
            try await supabase
                .from("peminjaman")
                .insert([
                    "id_buku": buku.id.uuidString,
                    "nama_peminjam": namaPeminjam,
                    "tanggal_pinjam": dateFormatter.string(from: tanggalPinjam),
                    "tanggal_kembali": dateFormatter.string(from: tanggalKembali)
                ])
                .execute()

            isSuccess = true
        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }
}
