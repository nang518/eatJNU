//
//  DetailView.swift
//  eatJNU
//
//  Created by 정나영 on 2023/02/07.
//

import SwiftUI

    struct DetailView: View {
    @Environment(\.presentationMode) var presentationMode: Binding <PresentationMode>
    @StateObject var viewModel = DetailNetwork()
    @StateObject var userModel = UserNetwork()
    var id: Int
    var userId: String
        
    init(id: Int, userId: String) {
        self.id = id
        self.userId = userId
    }
    
    var body: some View {
        ScrollView {
            //사진, 가게이름, 좋아요, 댓글 주소
            VStack {
                //URLImage
                let urlStr = viewModel.details.image
                if let encodedStr = urlStr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let myURL = URL(string: encodedStr) {
                    AsyncImage(url: myURL) { phase in
                        if let image = phase.image {
                            image
                                .resizable()
                                .frame(height: 450)
                            
                        }
                        else if phase.error != nil {
                            Text(phase.error?.localizedDescription ?? "error")
                                .foregroundColor(.pink)
                        }
                    }
                }
                
                HStack {
                    Text(viewModel.details.name)
                        .font(.system(size: 24))
                        .bold()
                    Spacer()
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 4)
                
                HStack {
                    Image("heart")
                        .resizable()
                        .frame(width: 24, height: 24)
                    Text("\(viewModel.details.likeCount)개")
                    Image("chat")
                        .resizable()
                        .frame(width: 24, height: 24)
                    Text("\(viewModel.details.reviewCount)개")
                    Spacer(minLength: 4)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 4)
                
                HStack {
                    Text(viewModel.details.location)
                    Spacer()
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 4)
            }
            
            Divider()
                .frame(minHeight: 8)
                .overlay(Color(.systemGray5))
            //매장 정보
            VStack(alignment: .leading) {
                HStack {
                    Text("매장 정보")
                        .bold()
                        .font(.system(size: 20))
                    Spacer()
                }
                .padding(.vertical, 4)
                
                HStack {
                    Image(systemName: "clock")
                    Text(viewModel.details.openingInfo)
                    Spacer()
                }
                .padding(.vertical, 4)
                
                HStack {
                    Image(systemName: "phone.fill")
                    Text(viewModel.details.number)
                    Spacer()
                }
                .padding(.vertical, 4)
                
                Text(viewModel.details.tags)
                    .foregroundColor(Color("tagColor"))
                    .font(.system(size: 14))
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 4)
            
            Divider()
                .frame(minHeight: 8)
                .overlay(Color(.systemGray5))
            //리뷰
            VStack(alignment: .leading) {
                HStack {
                    Text("리뷰 (\(viewModel.details.reviewCount))")
                        .bold()
                        .font(.system(size: 20))
                    Spacer()
                    
                    Text("리뷰 작성")
                        .foregroundColor(Color(.systemGray3))
                        .font(.system(size: 16))
                }
                //.padding(.horizontal, 32)
                //.padding(.vertical, 4)
                
                HStack {
                    TextField("", text: .constant("댓글을 입력해주세요 :)")).foregroundColor(Color.gray)
                    Image(systemName: "paperplane")
                }
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 2).foregroundColor(Color(.systemGray5)))
                //.padding(.horizontal, 8)
                //.padding(.vertical, 4)
                
                let randomImage = ["fox", "lion", "owl", "panda", "penguin", "rabbit2", "whale"]
                ForEach(viewModel.details.reviews, id: \.self) { review in
                    HStack {
                        Image(randomImage[review.comment.count % randomImage.count])
                            .resizable()
                            .frame(width: 30, height: 30)
                        VStack(alignment: .leading) {
                            Text("익명")
                                .font(.system(size: 14))
                                .bold()
                                .padding(.vertical, 2)
                            Text(review.comment)
                                .font(.system(size: 12))
                        }
                        
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 4)
            
            
            .task {
                //뷰가 그려지기 전에 호출
                viewModel.getPosts(url: "http://ec2-15-164-250-158.ap-northeast-2.compute.amazonaws.com/API/PlaceDetail/\(id)")
                userModel.getPosts(url: "http://ec2-15-164-250-158.ap-northeast-2.compute.amazonaws.com/API/LikePlace/\(userId)", placeId: id)
            }
            .navigationBarBackButtonHidden(true)
            .navigationTitle(viewModel.details.name)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading: btnBack)
            .navigationBarItems(trailing: userModel.isLikePlace ? AnyView(btnClickedFavorite) : AnyView(btnFavorite))
            
        }
    }
    
    var btnBack: some View {
        Button(action:{self.presentationMode.wrappedValue.dismiss()}){
            HStack{
                Image(systemName: "chevron.backward")
                    .font(.system(size: 20, weight: .light))
                    .foregroundColor(.black)
            }
        }
    }
    
    var btnClickedFavorite: some View {
        Button {
            userModel.deleteMethod(url: "http://ec2-15-164-250-158.ap-northeast-2.compute.amazonaws.com/API/LikePlace/\(userId)/\(id)")
            userModel.isLikePlace.toggle()
        } label: {
            Image(systemName: "heart.fill")
                .foregroundColor(.red)
        }
    }
    
    var btnFavorite: some View {
        Button {
            userModel.putMethod(url: "http://ec2-15-164-250-158.ap-northeast-2.compute.amazonaws.com/API/LikePlace/\(userId)/\(id)")
            userModel.isLikePlace.toggle()
        } label: {
            Image(systemName: "heart")
                .foregroundColor(.black)
//            Label("", systemImage: isFavorite ? "heart.fill" : "heart")
//                .labelStyle(.iconOnly)
//                .foregroundColor(isFavorite ? .red : .black)
        }
    }
    
//    @ViewBuilder
//    func btnFavorite() -> some View {
//        Button {
//            isFavorite.toggle()
//        } label: {
//            Label("", systemImage: isFavorite ? "heart.fill" : "heart")
//                .labelStyle(.iconOnly)
//                .foregroundColor(isFavorite ? .red : .black)
//        }
//    }
}
   
struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}


// temp
func getMethod(urlString: String) {
        guard let url = URL(string: urlString) else {
            print("Error: cannot create URL")
            return
        }
        // Create the url request
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                print("Error: error calling GET")
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
                
                print("메롱")
                print(prettyPrintedJson)
            } catch {
                print("Error: Trying to convert JSON data to string")
                return
            }
        }.resume()
    }
