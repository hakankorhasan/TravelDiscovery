//
//  NavigationLazyView.swift
//  TravelDiscovery
//
//  Created by Hakan Körhasan on 12.12.2022.
//

import SwiftUI

//verileri uygulama açılır açılmaz çekiyordu bu yapı ile birlikte sadece detay sayfasına gidilen verileri çekiyor

struct NavigationLazyView<Content: View>: View {
    let build: () -> Content
    init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }
    var body: Content {
        build()
    }
}
