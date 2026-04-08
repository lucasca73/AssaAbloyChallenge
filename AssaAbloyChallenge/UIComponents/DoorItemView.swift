//
//  DoorItemView.swift
//  AssaAbloyChallenge
//
//  Created by Lucas Costa Araujo on 08/04/26.
//

import SwiftUI

struct DoorItemView: View {
    @State var id: Int
    @State var title: String
    @State var subtitle: String
    @State var action: ((Int) -> Void)?
    
    var body: some View {
        Button {
            action?(id)
        } label: {
            VStack(alignment: .leading) {
                Text("\(title)")
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text("\(subtitle)")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.subheadline)
            }
            .frame(maxWidth: .infinity)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    List {
        DoorItemView(id: 1, title: "Title", subtitle: "Subtitle")
    }
}
