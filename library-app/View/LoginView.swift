//
//  LoginView.swift
//  library-app
//
//  Created by Valencia Melita Christy on 09/01/26.
//

import SwiftUI

struct LoginView: View {
    var body: some View {
        ZStack{
            VStack{
                Text("Login Admin")
                    .font(Font.largeTitle)
                    .bold(true)
                
                
                Form{
                    Section(header: Text("Username")){
                        TextField("Username", text: .constant(""))
                    }
                    Section(header: Text("Password")){
                        SecureField("Password", text: .constant(""))
                    }
                }
                .navigationBarTitle("Login")
                
            }
            
        }
        
    }
}


#Preview {
    LoginView()
}
