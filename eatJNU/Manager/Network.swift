//
//  Network.swift
//  eatJNU
//
//  Created by 정나영 on 2023/02/08.
//

import Foundation
import SwiftUI

class Network: ObservableObject {
    @Published var posts : ItemResponse = ItemResponse.sample
    

    func getPosts(url: String) {
        guard let url = URL(string: url) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                print("데이터가 존재하지 않습니다")
                return
            }

            guard error == nil else {
                print("오류: \(String(describing: error))")
                return
            }

            guard let response = response as? HTTPURLResponse else {
                print("잘못된 응답입니다")
                return
            }

            guard response.statusCode >= 200 && response.statusCode < 300 else {
                print("현재 Status Code는 \(response.statusCode) 입니다")
                return
            }
            print("데이터 다운로드 성공")

            let jsonString = String(data: data, encoding: .utf8)
//            print(jsonString)

            guard let newPost = try? JSONDecoder().decode(ItemResponse.self, from: data) else { return }
            DispatchQueue.main.async { [weak self] in
//                self?.posts.append(newPost[Item])
                self?.posts = newPost
//                print(self?.posts)
            }
        }
        .resume()
    }
}

class DetailNetwork: ObservableObject {
    @Published var details : DetailItem = DetailItem.sample
    
    func getPosts(url: String) {
        guard let url = URL(string: url) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                print("데이터가 존재하지 않습니다")
                return
            }

            guard error == nil else {
                print("오류: \(String(describing: error))")
                return
            }

            guard let response = response as? HTTPURLResponse else {
                print("잘못된 응답입니다")
                return
            }

            guard response.statusCode >= 200 && response.statusCode < 300 else {
                print("현재 Status Code는 \(response.statusCode) 입니다")
                return
            }
            print("데이터 다운로드 성공")

            let jsonString = String(data: data, encoding: .utf8)
            //print(jsonString)

            guard let newDetail = try? JSONDecoder().decode(DetailItem.self, from: data) else { return }
            DispatchQueue.main.async { [weak self] in

                self?.details = newDetail
                //print(self?.details)

            }
        }
        .resume()
    }
}

class UserNetwork: ObservableObject {
    @Published var userInfo : LikePlace = LikePlace.sample
    
    func getPosts(url: String) {
        guard let url = URL(string: url) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                print("데이터가 존재하지 않습니다")
                return
            }

            guard error == nil else {
                print("오류: \(String(describing: error))")
                return
            }

            guard let response = response as? HTTPURLResponse else {
                print("잘못된 응답입니다")
                return
            }

            guard response.statusCode >= 200 && response.statusCode < 300 else {
                print("현재 Status Code는 \(response.statusCode) 입니다")
                return
            }
            print("데이터 다운로드 성공")

            let jsonString = String(data: data, encoding: .utf8)
            //print(jsonString)

            guard let newUserInfo = try? JSONDecoder().decode(LikePlace.self, from: data) else { return }
            DispatchQueue.main.async { [weak self] in

                self?.userInfo = newUserInfo
                //print(self?.details)
            }
        }
        .resume()
    }
}
