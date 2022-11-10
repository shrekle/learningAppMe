//
//  HomeViewRow.swift
//  LearningAppMe
//
//  Created by adrian garcia on 10/26/22.
//

import SwiftUI

struct HomeViewRow: View {
    
    var image: String
    var title: String
    var description: String
    var lessonCount: String
    var time: String
    
    var body: some View {

        ZStack {
            Rectangle()
                .foregroundColor(.white)
                .cornerRadius(10)
                .shadow(radius: 5)
            HStack(spacing: 5) {
                Image(image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150, height: 150)
                    .clipShape(Circle())
                
                Spacer()
                
                VStack(alignment: .leading, spacing: 30) {
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text(title)
                            .font(.title)
                            .bold()
                        Text(description)
                            .font(.footnote)
                    }
                    HStack {
                        HStack {
                            Image(systemName: "book")
                            Text("\(lessonCount)")
                                .font(.caption)
                        }
                        Spacer()
                        HStack {
                            Image(systemName: "clock")
                            Text(time)
                                .font(.caption)
                        }
                    }
                }
            }
            .padding(10)
        }
        .aspectRatio(CGSize(width: 375, height: 175), contentMode: .fit)
    }
}

struct HomeViewRow_Previews: PreviewProvider {
    static var previews: some View {
        HomeViewRow(image: "swift", title: "learning", description: "whatever and blah blah blah", lessonCount: "10 lessons", time: "3 hours")
    }
}
