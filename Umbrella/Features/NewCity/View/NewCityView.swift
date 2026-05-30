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
    
    var isNight: Bool {
        let hour = Calendar.current.component(.hour, from: Date())
        return hour < 6 || hour >= 18
    }
    
    let countries = ["Cairo", "Alexandria", "London", "New York","Span","Germany","Italy","Japan"]
    
    var body: some View {
        ZStack {
            Image(isNight ? "night_sky" : "day_sky")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
                .blur(radius: 10, opaque: true)
            
            ScrollView {
                VStack(spacing: 12) {
                    ForEach(countries, id: \.self) { city in
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
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(.ultraThinMaterial, for: .navigationBar)
        .toolbarColorScheme(.dark, for: .navigationBar)
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
