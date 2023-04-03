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
    @State var text: String = ""
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
//                let urlStr = viewModel.details.image
//                if let encodedStr = urlStr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let myURL = URL(string: encodedStr) {
//                    AsyncImage(url: myURL) { phase in
//                        if let image = phase.image {
//                            image
//                                .resizable()
//                                .frame(height: 450)
//
//                        }
//                        else if phase.error != nil {
//                            Text(phase.error?.localizedDescription ?? "error")
//                                .foregroundColor(.pink)
//                        }
//                    }
//                }
                
                //image slider
                
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
                }
                //.padding(.horizontal, 32)
                //.padding(.vertical, 4)
                
                HStack {
                    if (viewModel.alreadyWrittenReview) {
                        TextField("", text: .constant("이미 리뷰를 입력하셨습니다!"))
                            .foregroundColor(Color("addReviewText"))
                        
                            
                        Button {
                            
                        } label: {
                            Image(systemName: "paperplane")
                                .foregroundColor(Color("addReviewText"))
                        }
                    } else {
                        
                        TextField("리뷰를 입력해주세요 :)", text: $text)
//                            .foregroundColor(Color("addReviewText"))
                            .foregroundColor(.black)
                            .background(Color("addReviewBackground"))
                        
                        Button {
                            if (5 <= text.count) {
                                if (text.count <= 99) {
                                    viewModel.postReview(url: "http://ec2-15-164-250-158.ap-northeast-2.compute.amazonaws.com/API/PlaceReview", userId: userId, placeId: id, comment: text)
                                    text = ""
                                }
                                else {
                                    // 100자 초과
                                }
                            } else { //5자 미만
                                
                            }
                            
                        } label: {
                            Image(systemName: "paperplane")
                                .foregroundColor(.black)
                        }
                    }
                
                    

                    
                }
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 2).foregroundColor(Color("addReviewBackground")))
                .background(Color("addReviewBackground"))
                
                
                let randomImage = ["fox", "lion", "owl", "panda", "penguin", "rabbit2", "whale", "chicken", "pig", "squid", "walrus"]
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
                viewModel.getPosts(url: "http://ec2-15-164-250-158.ap-northeast-2.compute.amazonaws.com/API/PlaceDetail/\(id)", userId: userId)
                viewModel.checkisLikePlace(url: "http://ec2-15-164-250-158.ap-northeast-2.compute.amazonaws.com/API/LikePlace/\(userId)", placeId: id)
            }
            .navigationBarBackButtonHidden(true)
            .navigationTitle(viewModel.details.name)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading: btnBack)
            .navigationBarItems(trailing: viewModel.isLikePlace ? AnyView(btnClickedFavorite) : AnyView(btnFavorite))
            
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
            viewModel.deleteFavoritePlace(url: "http://ec2-15-164-250-158.ap-northeast-2.compute.amazonaws.com/API/LikePlace/\(userId)/\(id)")
            viewModel.isLikePlace.toggle()
        } label: {
            Image(systemName: "heart.fill")
                .foregroundColor(.red)
        }
    }
    
    var btnFavorite: some View {
        Button {
            viewModel.putFavoritePlace(url: "http://ec2-15-164-250-158.ap-northeast-2.compute.amazonaws.com/API/LikePlace/\(userId)/\(id)")
            viewModel.isLikePlace.toggle()
        } label: {
            Image(systemName: "heart")
                .foregroundColor(.black)
        }
    }
}

   
struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
