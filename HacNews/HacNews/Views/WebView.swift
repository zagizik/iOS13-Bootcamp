//
//  WebView.swift
//  HacNews
//
//  Created by Александр Банников on 18.07.2020.
//  Copyright © 2020 Александр Банников. All rights reserved.


import SwiftUI

struct DetailView: View {
    
    let url: String?
    
    var body: some View {
        WebView(urlString: url)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(url: "https://google.com")
    }
}
