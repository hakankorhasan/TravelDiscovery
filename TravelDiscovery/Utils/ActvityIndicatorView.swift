//
//  ActvityIndicatorView.swift
//  TravelDiscovery
//
//  Created by Hakan Körhasan on 3.12.2022.
//

import SwiftUI

//Progress View
struct ActvityIndicatorView: UIViewRepresentable {
    
    func makeUIView(context: Context) -> UIActivityIndicatorView {
        let aiv = UIActivityIndicatorView(style: .large)
        aiv.color = .white
        aiv.startAnimating()
        return aiv
    }
    
    typealias UIViewType = UIActivityIndicatorView
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {
        
    }
    
}


struct ActvityIndicatorView_Previews: PreviewProvider {
    static var previews: some View {
        ActvityIndicatorView()
    }
}
