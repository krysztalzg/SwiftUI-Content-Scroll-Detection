//
//  ContentScrollDetector.swift
//  ScrollViewTest
//

import SwiftUI

private struct ContentScrollDetector: ViewModifier {

    @Binding var didScrollContent: Bool
    @State private var frame: CGRect = .zero

    func body(content: Content) -> some View {
        content
            .zIndex(.infinity)
            .overlay(GeometryReader { geometry in
                let currentFrame = geometry.frame(in: .named("ScrollViewCoordinate"))
                Color.clear
                    .onAppear { frame = currentFrame }
                    .onChange(of: currentFrame) {
                        frame = $0
                        withAnimation(.linear(duration: 0.2)) { didScrollContent = frame.minY < 0 }
                    }
            })
    }
}

extension View {
    func scrollDetection(_ didScrollContent: Binding<Bool>) -> some View {
        modifier(ContentScrollDetector(didScrollContent: didScrollContent))
    }
}
