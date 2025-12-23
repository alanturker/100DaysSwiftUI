//
//  GroupAsTransparentLayoutExample.swift
//  SnowSeeker
//
//  Created by Turker Alan on 23.12.2025.
//

import SwiftUI

struct GroupAsTransparentLayoutExample: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass

       var body: some View {
           if horizontalSizeClass == .compact {
               VStack {
                   UserView()
               }
           } else {
               HStack {
                   UserView()
               }
           }
           
           ViewThatFits {
               Rectangle()
                   .frame(width: 500, height: 200)

               Circle()
                   .frame(width: 200, height: 200)
           }
       }
       
//    if sizeClass == .compact {
//        VStack(content: UserView.init)
//    } else {
//        HStack(content: UserView.init)
//    }
}

#Preview {
    GroupAsTransparentLayoutExample()
}

private struct UserView: View {
    var body: some View {
        Group {
            Text("Name: Paul")
            Text("Country: England")
            Text("Pets: Luna and Arya")
        }
        .font(.title)
    }
}
