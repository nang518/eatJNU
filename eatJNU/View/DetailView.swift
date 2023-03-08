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
    @State var reviewInsert : String = ""
    var id: Int
    
    var body: some View {
        VStack {
            //URLImage
            let newStr = viewModel.details.image.replacingOccurrences(of: " ", with: "").trimmingCharacters(in: .whitespacesAndNewlines)
            let url = URL(string: newStr)
            
            if (url != nil){
                URLImage(url!) { image in
                    image
                        .resizable()
                        .frame(maxWidth: .infinity)
                }
                .padding(.vertical, 4)
            }
            //이미지가 없을 경우 기본 이미지 주소
            //            else {
            //                URLImage("") { image in
            //                    image
            //                        .resizable()
            //                }
            //            }
            
            VStack {
                HStack {
                    Text(viewModel.details.name)
                        .font(.system(size: 24))
                        .bold()
                    Spacer()
                }
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
                .padding(.vertical, 4)
                
                HStack {
                    Text(viewModel.details.location)
                    Spacer()
                }
            }
            .padding(.horizontal, 32)
            .padding(.vertical, 4)
        }
        
        Divider()
            .frame(minHeight: 8)
            .overlay(Color(.systemGray5))
        
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
                //.frame(alignment: .leading)
            
            
        }
        .padding(.horizontal, 32)
        .padding(.vertical, 4)
        
        Divider()
            .frame(minHeight: 8)
            .overlay(Color(.systemGray5))
        
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
        .onAppear {
            //뷰가 그려지기 전에 호출
            viewModel.getPosts(url: "http://ec2-15-164-250-158.ap-northeast-2.compute.amazonaws.com/API/PlaceDetail/\(id)")
        }
        .navigationBarBackButtonHidden(true)
        .navigationTitle(viewModel.details.name)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(leading: btnBack, trailing: btnHeart)
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

    var btnHeart: some View {
        NavigationLink(destination: MainView()) {
            Image(systemName: "heart.fill")
                .font(.system(size:20, weight: .light))
                .foregroundColor(.black)
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
