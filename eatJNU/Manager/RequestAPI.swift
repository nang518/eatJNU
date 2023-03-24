//
//  RequestAPI.swift
//  eatJNU
//
//  Created by 정나영 on 2023/02/08.
//

import Foundation

// MARK: - Welcome
struct ItemResponse: Codable {
    let items: [PostItem]
    
    static let sample = ItemResponse(items: [])
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
    var likeCount, reviewCount: Int
    let filter, tags: String
    let image: String
    let location, number, openingInfo: String
    let images: [placeImage]
    let lat, lon: Double 
    var reviews: [reviewInfo] = []
    
    static let sample = DetailItem(id: 0, name: "", likeCount: 0, reviewCount: 0, filter: "", tags: "", image: "", location: "", number: "", openingInfo: "", images: [ImageSample], lat: 0, lon: 0, reviews: [reviewSample])
    
    static let ImageSample = placeImage(url: "")
    static let reviewSample = reviewInfo(comment: "", writingTime: "", userId: "", likeCount: 0)
}

struct placeImage: Codable {
    let url: String
}

struct reviewInfo: Codable, Hashable, Identifiable {
    var id: String? {
        self.userId
    }
    let comment: String
    let writingTime: String
    var userId: String?
    let likeCount: Int
}

struct LikePlace: Codable {
    let items: [FavoriteInfo]
    
    static let sample = LikePlace(items: [favoriteSample])
    static let favoriteSample = FavoriteInfo(placeId: 0)
}

struct FavoriteInfo: Hashable, Codable, Identifiable {
    var id: Int {
        self.placeId
    }
    
    let placeId: Int
}

struct basicResponse: Codable {
    var isSuccess: Bool
}
