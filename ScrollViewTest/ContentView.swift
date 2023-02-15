//
//  ContentView.swift
//  ScrollViewTest
//

import SwiftUI

struct ContentView: View {

    @State private var didScrollContent: Bool = false

    var body: some View {
        ScrollViewReader { scrollProxy in
            VStack {
                if !didScrollContent {
                    ScrollView(.horizontal) {
                        HStack {
                            NavItem(title: "10")
                                .onTapGesture { scrollProxy.scrollTo(10) }
                            NavItem(title: "20")
                                .onTapGesture { scrollProxy.scrollTo(20) }
                            NavItem(title: "30")
                                .onTapGesture { scrollProxy.scrollTo(30) }
                            NavItem(title: "40")
                                .onTapGesture { scrollProxy.scrollTo(40) }
                        }
                    }
                }

                HeaderItem(didScrollContent: $didScrollContent, scrollProxy: scrollProxy)

                ScrollView(.vertical) {
                    LazyVStack {
                        ForEach(0..<50) { ix in
                            if ix == 0 {
                                ListItem(id: ix).scrollDetection($didScrollContent)
                            } else {
                                ListItem(id: ix)
                            }
                        }
                    }
                }
                .coordinateSpace(name: "ScrollViewCoordinate")
            }
        }
    }
}

// MARK: NavItem

struct NavItem: View {

    let title: String

    var body: some View {
        ZStack {
            VStack {
                Circle()
                    .foregroundColor(.black)
                    .frame(width: 32, height: 32)

                Text(title)
                    .font(.system(size: 16, weight: .bold))
            }
            .frame(width: 100)
            .padding(8)
        }
        .background(.gray)
        .cornerRadius(8)
    }
}

// MARK: HeaderItem

struct HeaderItem: View {

    @Binding var didScrollContent: Bool
    let scrollProxy: ScrollViewProxy

    var body: some View {
        ZStack {
            HStack {
                Circle()
                    .foregroundColor(.black)
                    .frame(width: 56, height: 56)
                    .padding(.trailing, 16)

                VStack(alignment: .leading) {
                    Text("Route #1")
                        .font(.system(size: 22, weight: .bold))

                    Text("12:00 | 120KM")
                        .font(.system(size: 16))
                }

                Spacer(minLength: 16)

                Circle()
                    .foregroundColor(.orange)
                    .frame(width: 48, height: 48)
                    .overlay(Image(systemName: "arrow.up"))
                    .onTapGesture { scrollProxy.scrollTo(0) }
                    .hidden(!didScrollContent)
            }
            .padding(8)
        }
        .background(.gray)
        .cornerRadius(didScrollContent ? 0 : 8)
        .padding(.horizontal, didScrollContent ? 0 : 16)
    }
}

// MARK: ListItem

struct ListItem: View {

    let id: Int

    var body: some View {
        ZStack {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("\(id) Apple Park Way in Cupertino, California")
                        .font(.system(size: 22, weight: .bold))

                    Text("\(Int.random(in: 8...20)):00")
                        .font(.system(size: 18))
                }

                Spacer()

                Circle()
                    .foregroundColor(.black)
                    .frame(width: 48, height: 48)
                    .overlay(content: { Text("\(Int.random(in: 1...10))").foregroundColor(.white) })
            }
            .padding(8)
        }
        .background(.gray)
        .cornerRadius(8)
        .padding(.horizontal, 16)
        .id(id)
    }
}

// MARK: - Preview

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
