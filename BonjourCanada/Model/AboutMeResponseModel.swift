//
//  AboutMeResponseModel.swift
//  BonjourCanada
//
//  Created by Jyoti Saini on 24/09/20.
//  Copyright © 2020 Jyoti Saini. All rights reserved.
//

import Foundation
struct AboutMeResponseModel: Decodable {
    var title: String
    var rows: [AboutMeRowItems]
}
