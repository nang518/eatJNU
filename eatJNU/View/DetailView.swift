//
//  DetailView.swift
//  eatJNU
//
//  Created by 정나영 on 2023/02/07.
//

import SwiftUI

//struct DetailView: View {
//    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
//    var body: some View {
//        VStack {
//
//        }
//        .padding(.horizontal, 32)
//        .navigationBarBackButtonHidden(true)
//        .navigationBarItems(leading: btnBack, trailing: btnHome)
//    }
//
//    var btnBack: some View {
//        Button(action:{self.presentationMode.wrappedValue.dismiss()}){
//            HStack{
//                Image(systemName: "chevron.backward")
//                    .font(.system(size: 20, weight: .light))
//                    .foregroundColor(.black)
//            }
//        }
//    }
//
//    var btnHome: some View {
//        NavigationLink(destination: MainView()) {
//            Image(systemName: "house")
//                .font(.system(size:20, weight: .light))
//        }
//    }
//}

struct DetailView: View {
    @StateObject var viewModel = Network()

    var id: Int
    var body: some View {
        VStack {
            Text("id는 \(id)얌")
        }
        .navigationBarItems(leading: Text("성공"))
        .onAppear {
            viewModel.getPosts(url: "http://ec2-15-164-250-158.ap-northeast-2.compute.amazonaws.com/API/PlaceDetail/\(id)")



        }
    }
}



struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
