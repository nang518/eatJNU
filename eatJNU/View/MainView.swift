//
//  MainView.swift
//  eatJNU
//
//  Created by 정나영 on 2023/02/07.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        
        
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
                Button {
                    
                } label: {
                    Text("후문")
                }
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, maxHeight: 48)
                .background(Color("JNUColor"))
                .font(.system(size: 24, weight: .bold))
                .kerning(10)
                
                //.padding(.vertical, 4)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.black, lineWidth: 4)
                )
                
                Spacer()
                    .frame(height: 16)
                Button {
                    
                } label: {
                    Text("상대")
                }
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, maxHeight: 48)
                .background(Color("JNUColor"))
                .font(.system(size: 24, weight: .bold))
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.black, lineWidth: 4)
                )
                .kerning(10)
                
                Spacer()
                    .frame(height: 16)
                Button {
                    
                } label: {
                    Text("정문")
                }
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, maxHeight: 48)
                .background(Color("JNUColor"))
                .font(.system(size: 24, weight: .bold))
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.black, lineWidth: 4)
                )
                .kerning(10)
            }
            .padding(.horizontal,32)
        }
        .padding(.horizontal, 16)
    }
}

struct MainButton: ButtonStyle {
    static let JNUColor = Color("JNUColor")
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(Color.white)
            
            .background(Color("JNUColor"))
            .frame(maxWidth: .infinity)
            
           
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
