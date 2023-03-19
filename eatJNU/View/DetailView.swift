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
    @State var isFavorite: Bool = false
    var id: Int
    var userId: String
    
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
                .padding(.horizontal, 32)
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
                .padding(.horizontal, 32)
                .padding(.vertical, 4)
                
                HStack {
                    Text(viewModel.details.location)
                    Spacer()
                }
                .padding(.horizontal, 32)
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
            .padding(.horizontal, 32)
            .padding(.vertical, 4)
            
            Divider()
                .frame(minHeight: 8)
                .overlay(Color(.systemGray5))
            //리뷰
            VStack {
                HStack {
                    Text("리뷰 (\(viewModel.details.reviewCount))")
                        .bold()
                        .font(.system(size: 20))
                    Spacer()
                    
                    Text("리뷰 작성")
                        .foregroundColor(Color(.systemGray3))
                        .font(.system(size: 16))
                }
                .padding(.horizontal, 32)
                .padding(.vertical, 4)
                
                HStack {
                    TextField("", text: .constant("댓글을 입력해주세요 :)")).foregroundColor(Color.gray)
                    Image(systemName: "paperplane")
                }
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 2).foregroundColor(Color(.systemGray5)))
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                
                VStack(alignment: .leading) {
                    let randomImage = ["fox", "lion", "owl", "panda", "penguin", "rabbit2", "whale"]
                    ForEach(viewModel.details.reviews, id: \.self) { review in
                        HStack {
                            Image(randomImage[review.comment.count % randomImage.count])
                                .resizable()
                                .frame(width: 20, height: 20)
                            VStack {
                                Text("익명")
                                    .font(.system(size: 14))
                                    .bold()
                                    .padding(.vertical, 2)
                                Spacer()
                                Text(review.comment)
                                    .font(.system(size: 12))
                            }
                            
                        }
                    }
                }
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                
            }
            
            
            .task {
                //뷰가 그려지기 전에 호출
                viewModel.getPosts(url: "http://ec2-15-164-250-158.ap-northeast-2.compute.amazonaws.com/API/PlaceDetail/\(id)")
                userModel.getPosts(url: "http://ec2-15-164-250-158.ap-northeast-2.compute.amazonaws.com/API/LikePlace/\(userId)")
            }
            .navigationBarBackButtonHidden(true)
            .navigationTitle(viewModel.details.name)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading: btnBack)
            .navigationBarItems(trailing: btnFavorite)
            
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
    
    var btnFavorite: some View {
        Button {
            isFavorite.toggle()
            
        } label: {
            Label("", systemImage: isFavorite ? "heart.fill" : "heart")
                .labelStyle(.iconOnly)
                .foregroundColor(isFavorite ? .red : .black)
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
