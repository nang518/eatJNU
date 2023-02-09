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
    let tags: String?
    let filter: String
}
