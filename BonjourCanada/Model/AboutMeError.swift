//
//  AboutMeError.swift
//  BonjourCanada
//
//  Created by Jyoti Saini on 24/09/20.
//  Copyright © 2020 Jyoti Saini. All rights reserved.
//

import Foundation

enum AboutMeError: LocalizedError, Equatable {
    case invalidRequestUrlString
    case invalidResponseModel
    case failedRequest(description: String)
    
    var errorDescription: String? {
        switch self {
        case .failedRequest(let description):
            return description
        case .invalidRequestUrlString, .invalidResponseModel:
            return ""
        }
    }
}
