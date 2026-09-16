//
//  MainList.swift
//  Sample App
//
//  Created by Andres Olguin on 23/08/2026.
//

import SwiftUI

struct MainList: View {
    @State private var password = ""
    
    var body: some View {
        List {
            
        }
        .navigationTitle("Pokémon List")
    }
}

#Preview {
    NavigationStack {
        MainList()
    }
}
