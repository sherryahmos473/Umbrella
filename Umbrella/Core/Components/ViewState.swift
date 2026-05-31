//
//  ViewState.swift
//  Umbrella
//
//  Created by Sherry Ahmos on 30/05/2026.
//

import Foundation

enum ViewState<T> {
    case loading
    case success(T)
    case failure(String)
}
