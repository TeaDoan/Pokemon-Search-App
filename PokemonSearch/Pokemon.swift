//
//  Pokemon.swift
//  PokemonSearch
//
//  Created by Thao Doan on 5/22/18.
//  Copyright © 2018 Thao Doan. All rights reserved.
//


import UIKit

struct Pokemon: Codable {
    
    let name : String
    let weight: Int
    let height: Int
    let id: Int
    let sprites : Sprite
}


struct Sprite : Codable {
    let spriteImage : String
    
    enum CodingKeys: String, CodingKey {
    case spriteImage = "front_default"
    }
}

