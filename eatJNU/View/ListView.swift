//
//  ListView.swift
//  eatJNU
//
//  Created by 정나영 on 2023/02/07.
//

import SwiftUI

struct ListView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var selectedCategory: Category = categories.first!
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            VStack {
                ScrollView(.horizontal, showsIndicators: false, content: {
                    HStack(spacing: 15) {
                        ForEach(categories) { category in
                            HStack(spacing: 10) {
                                Image(category.image)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 15, height: 15)
                                    .padding(6)
                                    .background(selectedCategory.id == category.id ? Color.white : Color.clear)
                                    .clipShape(Capsule())

                                Text(category.title)
                                    .fontWeight(.bold)
                                    .foregroundColor(selectedCategory.id == category.id ? .white : .black)
                            }
                            .padding(.vertical, 12)
                            .padding(.horizontal)
                            .background(selectedCategory.id == category.id ? Color("JNUColor") : Color.gray.opacity(0.08))
                            .clipShape(Capsule())
                            .shadow(color: Color.black.opacity(0.05), radius: 5, x: 5, y: 5)
                            .onTapGesture {
                                withAnimation(.spring()) {
                                    selectedCategory = category
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                    
                })
                
                ScrollView(.horizontal, showsIndicators: false, content: {
                    HStack(spacing: 20) {
                        
                    }
                    .padding()
                })
                
                
            }
                
        }
        .navigationBarItems(leading: btnBack)
        .navigationBarBackButtonHidden(true)
    }
    
    var btnBack: some View{
        Button(action:{self.presentationMode.wrappedValue.dismiss()}){
            HStack{
                Image(systemName: "chevron.backward")
                    .font(.system(size: 20, weight: .light))
                    .foregroundColor(.black)
            }
        }
    }
}

struct OutlineButtonSytle: ButtonStyle{
    static let JNUColor=Color("JNUColor")
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size:14).bold())
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.white)
                    .shadow(color: .gray, radius:2, x:0, y:2)
            )
//            .overlay(
//                RoundedRectangle(cornerRadius: 12)
//                    .stroke(OutlineButtonSytle.JNUColor, lineWidth: 3)
//            )
    }
}


//Swipe-back
extension UINavigationController: ObservableObject, UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }
    
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
