//
//  MainView.swift
//  eatJNU
//
//  Created by 정나영 on 2023/02/07.
//
import SwiftUI

struct MainView: View {
    var body: some View {
        
        ZStack {
            Color.white.ignoresSafeArea()
            
            VStack(spacing: 0) {
                Image("rabbit")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(.top,64)
           
                Text("전대 밥토끼")
                    .font(.custom("BMDoHyeon-OTF", size:48))
                    .padding(.bottom, 4)
                
                VStack {
                    Spacer()
                        .frame(height: 8)
                    
                    fstButton()
                    
                    Spacer()
                        .frame(height: 16)
                    sndButton()
                    
                    Spacer()
                        .frame(height: 16)
                    trdButton()
                }
                .padding(.horizontal,32)
            }
            
            .padding(.horizontal, 16)
        }
    }
    
    @ViewBuilder
    func fstButton() -> some View {
        NavigationLink(destination: ListView(areaType: 0)) {
           Text("후문")
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, maxHeight: 48)
                .background(Color("JNUColor"))
                .font(.system(size: 24, weight: .bold))
                .kerning(10)
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.black, lineWidth: 2)
                )
        }
    }
    
    @ViewBuilder
    func sndButton() -> some View {
        NavigationLink(destination: ListView(areaType: 1)) {
           Text("상대")
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, maxHeight: 48)
                .background(Color("JNUColor"))
                .font(.system(size: 24, weight: .bold))
                .kerning(10)
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.black, lineWidth: 2)
                )
        }
    }
    
    @ViewBuilder
    func trdButton() -> some View {
        NavigationLink(destination: ListView(areaType: 2)) {
           Text("정문")
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, maxHeight: 48)
                .background(Color("JNUColor"))
                .font(.system(size: 24, weight: .bold))
                .kerning(10)
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.black, lineWidth: 2)
                )
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
