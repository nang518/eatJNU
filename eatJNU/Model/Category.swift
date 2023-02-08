//
//  Category.swift
//  eatJNU
//
//  Created by 정나영 on 2023/02/08.
//

import SwiftUI

struct Category: Identifiable {
    var id: String = UUID().uuidString
    var image: String
    var title: String
}

var categories = [
    Category(image: "logo0", title: "전체"),
    Category(image: "logo1", title: "맛집"),
    Category(image: "logo2", title: "술집"),
    Category(image: "logo3", title: "카페")
]
