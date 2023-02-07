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
                    .buttonStyle(MainButton())
                    
                    Spacer()
                        .frame(height: 16)
                    Button {
                        
                    } label: {
                        Text("상대")
                    }
                    .buttonStyle(MainButton())
                    
                    Spacer()
                        .frame(height: 16)
                    Button {
                        
                    } label: {
                        Text("정문")
                    }
                    .buttonStyle(MainButton())
                }
                .padding(.horizontal,32)
            }
            .padding(.horizontal, 16)
        }

    }
    
    @ViewBuilder
    func searchButton() -> some View {
        NavigationLink(destination: SearchView()) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 44, weight: .light))
                .foregroundColor(Color("JNUColor"))
            
        }
        .navigationBarBackButtonHidden(true)
    }
    
    
}

struct MainButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.white)
            .frame(maxWidth: .infinity, maxHeight: 48)
            .background(Color("JNUColor"))
            .font(.system(size: 24, weight: .bold))
            .kerning(10)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.black, lineWidth: 4)
            )
            
           
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
