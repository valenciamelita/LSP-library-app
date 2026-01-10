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
    
    override func load() async {
          await fetchBukuTersedia()
      }

    func fetchBukuTersedia() async {
        do {
            let response = try await supabase
                .from("buku")
                .select()
                .eq("status", value: "tersedia")
                .order("judul_buku", ascending: true)
                .execute()

            bukuList = try makeJSONDecoder().decode(
                [Buku].self,
                from: response.data
            )
        } catch {
            errorMessage = error.localizedDescription
        }
    }

    func submit() async {
        guard let buku = selectedBuku else {
            errorMessage = "Buku harus dipilih"
            return
        }

        isLoading = true
        errorMessage = nil

        do {
            let tanggalKembali = Calendar.current.date(
                byAdding: .day,
                value: 7,
                to: tanggalPinjam
            )!

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
