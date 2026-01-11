//
//  Supabase.swift
//  library-app
//
//  Created by Valencia Melita Christy on 09/01/26.
//

// Instance global SupabaseClient
// Digunakan sebagai penghubung aplikasi dengan backend Supabase
// Menyediakan akses ke database, autentikasi, dan storage

import Foundation
import Supabase

let supabase = SupabaseClient(
    supabaseURL: URL(string: "https://motablfkzbqtzsbsomrp.supabase.co")!,
    supabaseKey: "sb_publishable_2e4MMJrA8hY3tRVVCJhyCg_cItTMFh9")
