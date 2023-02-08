//
//  RequestAPI.swift
//  eatJNU
//
//  Created by 정나영 on 2023/02/08.
//

import Foundation

// MARK: - Welcome
struct ItemResponse: Codable {
    let count: Int
    let items: [Item]
}

// MARK: - Item
struct Item: Identifiable, Codable {
    let id: Int
    let name: String
    let image: String
    let reviewCount, likeCount: Int
    let tags: Tags
    
    enum Name: String, Codable {
        case 다원 = "다원"
    }

    enum Tags: String, Codable {
        case 가성비맛집볶음밥삼겹살 = "#가성비 #맛집 #볶음밥 #삼겹살"
    }
}

