//
//  Api.swift
//  Fusion (iOS)
//
//  Created by Zablon Charles on 2/25/22.
//

import SwiftUI
import Foundation

//MARK: MODEL
struct Post: Codable{
   
    var date: String
    var name: String
}


//MARK: VIEW MODEL
class Api {
    func getPosts (completion: @escaping ([Post]) -> ()) {
        
        guard let url = URL(string: "https://date.nager.at/api/v3/PublicHolidays/2022/AT") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            let posts = try! JSONDecoder().decode([Post].self, from: data!)
            
            DispatchQueue.main.async {
                completion(posts)
            }
        }
        .resume()
    }
}

//MARK: VIEW
struct ContentView: View {
    @State var posts: [Post] = []
    var pics = ["cover1", "cover2", "cover3", "cover4", "cover5", "cover6"]
    var columns: [GridItem] =
    [.init(.adaptive(minimum: 200, maximum: 200))]
    
    var body: some View {
        
        ZStack {
            Color.offWhite.edgesIgnoringSafeArea(.all)
            ScrollView {
                
                LazyVGrid(columns: columns) {
                    ForEach(posts, id: \.date) { post in
                        
                        
                        
                        VStack(alignment: .leading, spacing: 3) {
                            
                            
                            RoundedRectangle(cornerRadius: 20)
                                .fill(.clear)
                                .background(
                                    Image(pics.randomElement() ?? "ob1")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                    
                                )
                            
                            
                                .shadow(color:  Color("black").opacity(0.2), radius: 10, x: 10, y: 10 )
                                .shadow(color: Color("white").opacity(0.9),radius: 10, x: -5, y: -5)
                            
                                .cornerRadius(15)
                                .padding(-5)
                            
                            Spacer()
                            
                            Text(post.date)
                                .customfontFunc(customFont: "sanfrancisco", style: .caption1)
                                .foregroundColor(.secondary)
                                .lineLimit(1)
                            
                            Text(post.name)
                                .customfontFunc(customFont: "sanfrancisco", style: .callout)
                        }
                        .padding()
                        .background(Color.offWhite)
                        .scaleEffect( 1 )
                        .frame(width: 190, height: 300)
                        .offwhitebutton(isTapped: false, isToggle: false, cornerRadius: 15)
                        .padding()
                        
                        
                    }
                }.padding(10)
                
            } .onAppear {
                Api().getPosts { (posts) in
                    self.posts = posts
                }
            }
            
        }
    }
}

struct ContentViewProvider_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
