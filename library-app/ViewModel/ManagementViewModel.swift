//
//  ManagementViewModel.swift
//  library-app
//
//  Created by Valencia Melita Christy on 10/01/26.
//

import Foundation
import Supabase
import Combine

@MainActor
class ManagementViewModel: BaseViewModel {

    @Published var peminjamanList: [Peminjaman] = []
    
    // Polymorphism
    override func load() async {
          await fetchPeminjaman()
      }
    
    func fetchPeminjaman() async {
           isLoading = true
           errorMessage = nil

           do {
               let response = try await supabase
                   .from("peminjaman")
                   .select("""
                       id_peminjaman,
                       nama_peminjam,
                       tanggal_pinjam,
                       tanggal_kembali,
                       tanggal_dikembalikan,
                       created_at, 
                       buku (
                           judul_buku,
                           cover_url
                       )
                   """)
                   .order("created_at", ascending: false)
                   .execute()
               
               print(String(data: response.data, encoding: .utf8)!)
               
               let decoder = makeJSONDecoder()
               peminjamanList = try decoder.decode(
                   [Peminjaman].self,
                   from: response.data
               )

           } catch {
               errorMessage = error.localizedDescription
           }

           isLoading = false
       }
    // Overloading #1 (dipanggil dari View)
    func markAsReturned(peminjaman: Peminjaman) async {
        await markAsReturned(id: peminjaman.id)
    }

    // Overloading #2 (logic inti)
    func markAsReturned(id: UUID) async {
        do {
            try await supabase
                .from("peminjaman")
                .update([
                    "tanggal_dikembalikan": dateFormatter.string(from: Date())
                ])
                .eq("id_peminjaman", value: id.uuidString)
                .execute()

            await fetchPeminjaman()

        } catch {
            errorMessage = error.localizedDescription
        }
    }
}

