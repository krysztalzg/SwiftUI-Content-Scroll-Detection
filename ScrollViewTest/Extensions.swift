//
//  Extensions.swift
//  ScrollViewTest
//

import SwiftUI

// MARK: Inline

@discardableResult @inlinable internal func with<T>(_ subject: T, _ transform: (_ subject: inout T) throws -> Void) rethrows -> T {
    var subject = subject
    try transform(&subject)
    return subject
}

// MARK: View

extension View {

    // MARK: Properties

    /// Converts `View` to `AnyView` type.
    var asAnyView: AnyView {
        AnyView(self)
    }

    /// Hides view based on the given flag value.
    @ViewBuilder func hidden(_ shouldHide: Bool) -> some View {
        if shouldHide { hidden() } else { self }
    }
}

// MARK: ScrollViewProxy

extension ScrollViewProxy {

    func scrollTo(_ index: Int) {
        withAnimation(.linear(duration: 0.2)) {
            scrollTo(index, anchor: .top)
        }
    }
}
