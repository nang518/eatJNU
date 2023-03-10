//
//  PopularItemRowView.swift
//  eatJNU
//
//  Created by 정나영 on 2023/02/08.
//

import SwiftUI
import URLImage

struct PopularItemRowView: View {
    @StateObject var viewModel = Network()

    private var selectedFilterNum: Int
    private var areaTypeNum: Int

    init(selectedFilterNum: Int, areaTypeNum: Int) {
        self.selectedFilterNum = selectedFilterNum
        self.areaTypeNum = areaTypeNum
    }

    
    var body: some View {
        VStack {
            if (selectedFilterNum == 1) {
                Spacer()
                FilterItem(filter: "맛집")
            }
            else if (selectedFilterNum == 2) {
                Spacer()
                FilterItem(filter: "술집")
            }
            else if (selectedFilterNum == 3) {
                Spacer()
                FilterItem(filter: "카페")
            }
            else if (selectedFilterNum == 0) {
                Spacer()
                WholeItem()
            }
        }
    }
    
    @ViewBuilder
    func FilterItem(filter: String) -> some View {
        VStack { 
            ForEach(viewModel.posts.items) { post in
                let urlStr = post.image.replacingOccurrences(of: "", with: "")
                let url = URL(string: urlStr)!
                
                if(filter == post.filter) {
                    HStack(spacing: 2) {
                        NavigationLink(destination: DetailView(id: post.id)) {
                            URLImage(url) { image in
                                image
                                    .resizable()
                                    .frame(width: 88, height: 88)
                                    .overlay(
                                    RoundedRectangle(cornerRadius: 24)
                                        .stroke(Color.black, lineWidth: 2)
                                    )
                                    .cornerRadius(24)
                            }
                            
                            VStack(alignment: .leading, spacing: 2) {
                                Text(post.name)
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundColor(.black)
                                
                                HStack {
                                    Image("heart")
                                        .resizable()
                                        .frame(width: 18, height: 18)
                                    
                                    Text("\(post.likeCount)")
                                        .font(.custom("BMDOHYEON-OTF", size: 14))
                                        .foregroundColor(.black)
                                    
                                    Text("리뷰 \(post.reviewCount)")
                                        .font(.system(size: 14))
                                        .foregroundColor(Color("reviewColor"))
                                }
                                Spacer()
                                    .frame(height: 1)   
                                
                                if (post.tags != nil) {
                                    Text(post.tags!)
                                        .foregroundColor(Color("tagColor"))
                                        .font(.system(size: 12))
                                        .multilineTextAlignment(.leading)
                                }
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            
                        }
                    }
                    .padding(.vertical, 4)
                }
            }
        }
        .onAppear {
            viewModel.getPosts(url: "http://ec2-15-164-250-158.ap-northeast-2.compute.amazonaws.com/API/PlaceList/\(areaTypeNum)")
        }
    }
    
    @ViewBuilder
    func WholeItem() -> some View {
        VStack {
            ForEach(viewModel.posts.items) { post in
                let urlStr = post.image.replacingOccurrences(of: " ", with: "")
                let url = URL(string: urlStr)!
                
                HStack(spacing: 2) {
                    NavigationLink(destination: DetailView(id: post.id)) {
                        URLImage(url) { image in
                            image
                                .resizable()
                                .frame(width: 88, height: 88)
                                .overlay(
                                RoundedRectangle(cornerRadius: 24)
                                    .stroke(Color.black, lineWidth: 2)
                                )
                                .cornerRadius(24)
                        }
                        
                        VStack(alignment: .leading, spacing: 2) {
                            Text(post.name)
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(.black)
                            
                            HStack {
                                Image("heart")
                                    .resizable()
                                    .frame(width: 18, height: 18)
                                
                                Text("\(post.likeCount)")
                                    .font(.custom("BMDOHYEON-OTF", size: 14))
                                    .foregroundColor(.black)
                                
                                Text("리뷰 \(post.reviewCount)")
                                    .font(.system(size: 14))
                                    .foregroundColor(Color("reviewColor"))
                            }
                            Spacer()
                                .frame(height: 1)
                            
                            if (post.tags != nil) {
                                Text(post.tags!)
                                    .foregroundColor(Color("tagColor"))
                                    .font(.system(size: 12))
                                    .multilineTextAlignment(.leading)
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        //.padding()
                    }
                }
            }
        }
        .onAppear {
            viewModel.getPosts(url: "http://ec2-15-164-250-158.ap-northeast-2.compute.amazonaws.com/API/PlaceDetail/\(areaTypeNum)")
        }
    }
}

struct PopularItemRowView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
