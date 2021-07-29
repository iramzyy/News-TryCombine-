//
//  ResultState.swift
//  News-App
//
//  Created by Ramzy on 28/07/2021.
//

import Foundation

enum ResultState {
    case loading
    case success(content: [Article])
    case failed(error: Error)
}
