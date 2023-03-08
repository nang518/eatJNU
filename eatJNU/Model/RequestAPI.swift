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
    let items: [PostItem]
    
    static let sample = ItemResponse(count: 0, items: [])
}

// MARK: - Item
struct PostItem: Identifiable, Codable {
    let id: Int
    let name: String
    let image: String
    let reviewCount, likeCount: Int
    let tags: String?
    let filter: String
    
}

struct DetailItem: Codable {
    let id: Int
    let name: String
    let likeCount, reviewCount: Int
    let filter, tags: String
    let image: String
    let location, number, openingInfo: String
    let images: [placeImage]
    let lat, lon: Double 
    let reviews: [reviewInfo]
    
    static let sample = DetailItem(id: 0, name: "", likeCount: 0, reviewCount: 0, filter: "", tags: "", image: "", location: "", number: "", openingInfo: "", images: [ImageSample], lat: 0, lon: 0, reviews: [reviewSample])
    
    static let ImageSample = placeImage(url: "")
    static let reviewSample = reviewInfo(comment: "", writingTime: "", userId: "", likeCount: 0)
}

struct placeImage: Codable {
    let url: String
}

struct reviewInfo: Codable {
    let comment: String
    let writingTime: String
    var userId: String?
    let likeCount: Int
}
