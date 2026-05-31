//
//  NewCityView.swift
//  Umbrella
//
//  Created by Sherry Ahmos on 29/05/2026.
//

import SwiftUI

struct AddCityView: View {
    @StateObject private var viewModel = AddCityViewModel()
    @Environment(\.dismiss) private var dismiss
    
    @State private var showSnackbar = false
    @State private var addedCityName = ""

    
    var body: some View {
        ZStack {
            
            ScrollView {
                VStack(spacing: 12) {
                    ForEach(viewModel.countries, id: \.self) { city in
                        AddCity(city: city) {
                            addedCityName = city
                            viewModel.addCityToFavorites(city)
                        }
                    }
                }
                .padding()
            }
            
            if showSnackbar {
                CustomSnackBar(name: addedCityName)
            }
        }.withWeatherBackground()
        .weatherNavigationStyle()
        .navigationTitle("Add City")
        
        .onChange(of: viewModel.isSaveSuccess) { _, isSuccess in
            if isSuccess {
                withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                    showSnackbar = true
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    withAnimation {
                        showSnackbar = false
                    }
                    dismiss()
                }
            }
        }
        .alert("Database Error", isPresented: Binding(
            get: { viewModel.errorMessage != nil },
            set: { _ in viewModel.errorMessage = nil }
        )) {
            Button("Dismiss", role: .cancel) { }
        } message: {
            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
            }
        }
    }
}
