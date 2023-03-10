//
//  DetailView.swift
//  eatJNU
//
//  Created by 정나영 on 2023/02/07.
//

import SwiftUI
import URLImage


struct DetailView: View {
    @Environment(\.presentationMode) var presentationMode: Binding <PresentationMode>
    @StateObject var viewModel = DetailNetwork()
    var id: Int
    
    var body: some View {
        ScrollView {
            //사진, 가게이름, 좋아요, 댓글 주소
            VStack {
                //URLImage
                let urlStr = viewModel.details.image
                if let encodedStr = urlStr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let myURL = URL(string: encodedStr) {
                    //let _ = print(myURL)
//                    URLImage(myURL) { image in
//                        image
//                            .resizable()
//                            .frame(height: 400)
//
//                    }
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
                
                let uuid = UUID().uuidString
                
                let _ = print(uuid)
                
//                let url =  URL(string: encodedStr)!
//                let _ = print(url.absoluteString)
                
//                if (url != nil){
//                    URLImage(url!) { image in
//                        image
//                            .resizable()
//                            .frame(height: 400)
//                    }
//                    .padding(.vertical, 4)
//                }
                
                
                //github.com/younhwan97/eatJNU/blob/main/preview/image1.jpeg?raw=true
                //이미지가 없을 경우 기본 이미지 주소
                //            else {
                //                URLImage("") { image in
                //                    image
                //                        .resizable()
                //                }
                //            }
            
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
                    Text("리뷰")
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
                
                
                
            }
        }
        .task {
            //뷰가 그려지기 전에 호출
            viewModel.getPosts(url: "http://ec2-15-164-250-158.ap-northeast-2.compute.amazonaws.com/API/PlaceDetail/\(id)")
        }
        .navigationBarBackButtonHidden(true)
        .navigationTitle(viewModel.details.name)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(leading: btnBack)   
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

//    var btnHeart: some View {
//        if(self.isFavorite) {
//            Image(systemName: "heart.fill")
//                .foregroundColor(.red)
//        } else {
//            Image(systemName: "heart")
//                .foregroundColor(.black)
//
//        }
//    }
}



struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
