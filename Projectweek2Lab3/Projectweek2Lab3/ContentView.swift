//
//  ContentView.swift
//  Projectweek2Lab3
//
//  Created by Afrah Faisal on 15/01/1445 AH.
//

import SwiftUI
class user :ObservableObject{
    var  representdata : String = ""
}
struct LanguageData:Identifiable{
    let id:UUID = UUID()
    let category : CardCategory
    let imageURL: URL?
}
enum CardCategory{
    case C, Java ,Python
}
struct CardView: View {
    let data: LanguageData
    var body: some View {
        GeometryReader { geometryProxy in
            ZStack {
                AsyncImage(url: data.imageURL) { result in
                    if let image = result.image {
                        image
                            .resizable()
                            .scaledToFill()
                    } else {
//                        Rectangle()
//                            .fill(Color.black.opacity(0.1))
                        ProgressView()
                    }
                }
                .frame(
                    width: geometryProxy.size.width,
                    height: geometryProxy.size.height
                )
                .padding(8)
                .foregroundColor(.white)
                .background(
                    Gradient(
                        colors: [
                            Color.clear,
                            Color.clear,
                            Color.clear,
                            Color.black
                        ]
                    )
                )
            }
            .cornerRadius(12)
            .frame(
                width: geometryProxy.size.width,
                height: geometryProxy.size.height
            )
        }
    }
}
func makeLanguageData()->Array<LanguageData>{
    return
    Array(
        repeating: LanguageData(
            category : .C,
            imageURL: URL(string: "https://source.unsplash.com/500x300/?C")),
        count: 3) +
    //Java
    Array(
        repeating: LanguageData(
            category : .Java,
            imageURL: URL(string: "https://source.unsplash.com/500x300/?Java")),
        count: 3) +
    //Python
    Array(
        repeating: LanguageData(
            category : .Python,
            imageURL: URL(string: "https://source.unsplash.com/500x300/?Python")),
        count: 3)
}
struct ContentView: View {
    let programminglanguage : Array<String> = [
        "C",
        "Java",
        "Python"
    ]
    let language:Array<LanguageData> = makeLanguageData()
    @State var filteredCard:Array<LanguageData>=[]
    @State var searchText:String=""
    var body: some View {
        NavigationView{
            VStack{
                HStack {
                    Text("")
                        .navigationTitle(" Programming")
                        .toolbar{
                            ToolbarItemGroup(placement: .primaryAction) {NavigationLink(destination: Text("hello"), label: {Text("About")})
                              TextField("search", text: $searchText)
                            }
                        }
                }
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(programminglanguage, id: \.self) { category in
                            Button(
                                action: {
                                    switch category{
                                    case "C":
                                        filteredCard=language.filter({card in card.category == .C})
                                    case  "Java":
                                        filteredCard=language.filter({card in card.category == .Java})
                                    case   "Python" :
                                        filteredCard=language.filter({card in card.category == .Python})
                                    default:
                                        filteredCard = language
                                    }
                                },
                                label: {
                                    Text(category)
                                        .padding(.vertical, 8)
                                        .padding(.horizontal, 16)
                                        .background(Color.gray.opacity(0.3))
                                        .foregroundColor(Color.black)
                                        .cornerRadius(12)
                                }
                            )
                        }
                    }
                }
                .padding()
            }
            ScrollView(.horizontal) {
                HStack {
                    ForEach(language.filter({card in card.category == .C})) { card in
                        CardView(data: card)
                            .frame(width: 300, height: 150)
                    }
                }
            }
            ScrollView(.horizontal) {
                HStack {
                    ForEach(language.filter({card in card.category == .Java})) { card in
                        CardView(data: card)
                            .frame(width: 300, height: 150)
                    }
                }
            }
            ScrollView(.horizontal) {
                HStack {
                    ForEach(language.filter({card in card.category == .Python})) { card in
                        CardView(data: card)
                            .frame(width: 300, height: 150)
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
