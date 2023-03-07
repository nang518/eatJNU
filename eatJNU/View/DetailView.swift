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
        VStack {
            //let urlStr = viewModel.details.image.replacingOccurrences(of: "", with: "")
            let url = URL(string: viewModel.details.image)!
            
            URLImage(url) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
       
            HStack {
                Text(viewModel.details.name)
                    .font(.system(size: 32))
                    .bold()
                Spacer()
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 32)
            
            HStack {
                Image(systemName: "heart")
                Text("\(viewModel.details.likeCount)개")
                Image(systemName: "pencil")
                Text("\(viewModel.details.reviewCount)개")
                Spacer()
            }
            .padding(.vertical, 4)
            .padding(.horizontal, 32)
            
            HStack {
                Text(viewModel.details.location)
                Spacer()
            }
            .padding(.horizontal, 32)
            
            Divider()
                .frame(minHeight: 8)
                .overlay(Color(.systemGray5))
                
            
            HStack {
                Text("매장 정보")
                    .bold()
                    .font(.system(size: 20))
                Spacer()
            }
            .padding(.horizontal, 32)
            .padding(.vertical, 4)
            
            HStack {
                Image(systemName: "clock")
                Text(viewModel.details.openingInfo)
                Spacer()
            }
            .padding(.horizontal, 32)
            
            HStack {
                Image(systemName: "phone.fill")
                Text(viewModel.details.number)
                Spacer()
            }
            .padding(.horizontal, 32)
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
