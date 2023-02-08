//
//  ContentView.swift
//  eatJNU
//
//  Created by 정나영 on 2023/02/07.
//

import SwiftUI

//struct PostModel: Identifiable, Codable {
//    let userId: Int
//    let id: Int
//    let title: String
//    let body: String
//}
//
//class DownloadWithEscapingViewModel: ObservableObject {
//    @Published var posts: [PostModel] = []
//
//    init() {
//        getPosts()
//    }
//
//    func getPosts() {
//        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts/1") else { return }
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            guard let data = data else {
//                print("데이터가 존재하지 않습니다")
//                return
//            }
//
//            guard error == nil else {
//                print("오류: \(String(describing: error))")
//                return
//            }
//
//            guard let response = response as? HTTPURLResponse else {
//                print("잘못된 응답입니다")
//                return
//            }
//
//            guard response.statusCode >= 200 && response.statusCode < 300 else {
//                print("현재 Status Code는 \(response.statusCode) 입니다")
//                return
//            }
//            print("데이터 다운로드 성공")
//            print(data)
//
//            guard let newPost = try? JSONDecoder().decode(PostModel.self, from: data) else { return }
//            DispatchQueue.main.async { [weak self] in
//                self?.posts.append(newPost)
//            }
//        }
//        .resume()
//    }
//}

struct ContentView: View {
    @StateObject var vm = Network()
    var body: some View {
        ScrollView {
            Text("바보")
            ForEach(vm.posts.items) { post in
                VStack(spacing: 10) {
                    Text(post.name)
                        .font(Font.title.bold())
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PopularItemRowView()
        }
        }
       
}
