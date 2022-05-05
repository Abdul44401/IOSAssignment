//
//  StickerModel.swift
//  IOSAssignment
//
//  Created by Abdul Razzak on 29/04/2022.
//

import Foundation

struct StickerModel: Identifiable, Hashable {
    var stock: String
    var price: String
    let id = UUID()
}

