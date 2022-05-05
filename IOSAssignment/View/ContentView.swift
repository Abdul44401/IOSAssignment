//
//  ContentView.swift
//  IOSAssignment
//
//  Created by Abdul Razzak on 26/04/2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var vm = AppViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                
                VStack (spacing: 0) {
                    // This view is to show CSV data
                    TopView(vm: vm)
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        // This view is to show 6 rows of Json Data
                        MiddleView(vm: vm)
                        
                        // This view is to remaining data from Json
                        BottomView(vm: vm)
                    }
                    .padding(.top)
                    
                    Spacer()
                }
                
                SwiftUIActivityIndicator(isAnimating: vm.isActivityAnimation)
                    .opacity(vm.isActivityAnimation ? 1 : 0)
            }
        }
    }
}

//MARK: - Top VIew
struct TopView: View {
    @ObservedObject var vm: AppViewModel
    @State private var currentPage = 0
    
    var body: some View {
        PagingView(pageCount: vm.sticker.count, currentIndex: $currentPage) {
            
            ForEach(vm.sticker, id:\.id) { value in
                CardView(sticker: value)
            }
        }
    }
}

//MARK: - Middle View
struct MiddleView: View {
    @ObservedObject var vm: AppViewModel
    var body: some View {
        ScrollView (.horizontal, showsIndicators: false) {
            LazyHStack {
                TabView {
                    ForEach (0..<2) { column in
                        ZStack{
                            RoundedRectangle(cornerRadius: 8, style: .continuous)
                                .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                                .padding()
                                .shadow(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.13)), radius: 15, x: 0.0, y: 5.0)
                                .overlay(
                                    TopSixNews(vm: vm, columns: column)
                                )
                        }
                    }
                }
            
                .frame(width: UIScreen.main.bounds.width, height: 290)
                .tabViewStyle(PageTabViewStyle())
            }
        }
    }
}

//MARK: - Bottom View
struct BottomView: View {
    @ObservedObject var vm: AppViewModel
    var body: some View {
        ScrollView (.vertical, showsIndicators: false) {
            LazyVStack {
                ForEach(vm.filterArticles, id:\.title) { row in
                    CellView(article: row)
                }
                Spacer()
            }
            .padding()
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
