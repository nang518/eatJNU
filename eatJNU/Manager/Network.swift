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
                // print(self?.details)
            }
        }
        .resume()
    }
}

class UserNetwork: ObservableObject {
    @Published var userInfo : LikePlace = LikePlace.sample
    @Published var isLikePlace : Bool = false
    
    func getPosts(url: String, placeId: Int) {
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
                
                for item in newUserInfo.items {
                    if (item.placeId == placeId) {
                        self?.isLikePlace.toggle()
                        break
                    }
                }
            }
        }
        .resume()
    }
    
    func putMethod(url: String) {
            guard let url = URL(string: url) else {
                print("Error: cannot create URL")
                return
            }
                                    
            // Create the request
            var request = URLRequest(url: url)
            request.httpMethod = "PUT"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            URLSession.shared.dataTask(with: request) { data, response, error in
                guard error == nil else {
                    print("Error: error calling PUT")
                    print(error!)
                    return
                }
                guard let data = data else {
                    print("Error: Did not receive data")
                    return
                }
                guard let response = response as? HTTPURLResponse, (200 ..< 299) ~= response.statusCode else {
                    print("Error: HTTP request failed")
                    return
                }
                do {
                    guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                        print("Error: Cannot convert data to JSON object")
                        return
                    }
                    guard let prettyJsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted) else {
                        print("Error: Cannot convert JSON object to Pretty JSON data")
                        return
                    }
                    guard let prettyPrintedJson = String(data: prettyJsonData, encoding: .utf8) else {
                        print("Error: Could print JSON in String")
                        return
                    }
                    
                    print(prettyPrintedJson)
                } catch {
                    print("Error: Trying to convert JSON data to string")
                    return
                }
            }.resume()
        }
    
    func deleteMethod(url: String) {
            guard let url = URL(string: url) else {
                print("Error: cannot create URL")
                return
            }
                                    
            // Create the request
            var request = URLRequest(url: url)
            request.httpMethod = "DELETE"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            URLSession.shared.dataTask(with: request) { data, response, error in
                guard error == nil else {
                    print("Error: error calling PUT")
                    print(error!)
                    return
                }
                guard let data = data else {
                    print("Error: Did not receive data")
                    return
                }
                guard let response = response as? HTTPURLResponse, (200 ..< 299) ~= response.statusCode else {
                    print("Error: HTTP request failed")
                    return
                }
                do {
                    guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                        print("Error: Cannot convert data to JSON object")
                        return
                    }
                    guard let prettyJsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted) else {
                        print("Error: Cannot convert JSON object to Pretty JSON data")
                        return
                    }
                    guard let prettyPrintedJson = String(data: prettyJsonData, encoding: .utf8) else {
                        print("Error: Could print JSON in String")
                        return
                    }
                    
                    print(prettyPrintedJson)
                } catch {
                    print("Error: Trying to convert JSON data to string")
                    return
                }
            }.resume()
        }
}

