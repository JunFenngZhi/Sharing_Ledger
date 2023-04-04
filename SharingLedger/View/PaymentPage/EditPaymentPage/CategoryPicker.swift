//
//  CategoryPicker.swift
//  SharingLedger
//
//  Created by Loaner on 4/3/23.
//

import SwiftUI

struct CategoryPicker: View {
    let categoryList: [Category]

    @Binding var selectedCategoryIndex: Int

    var body: some View {
        HStack(spacing: 20) {
            ForEach(0..<categoryList.count) { index in
                Button(action: {
                    self.selectedCategoryIndex = index
                }) {
                    VStack{
                        Image(categoryList[index].rawValue)
                            .resizable()
                            .frame(width: 50, height: 50)
                        Text(categoryList[index].rawValue)
                            .fontWeight(.light)
                            .font(.footnote)

                    }
                }
                .accentColor(index == selectedCategoryIndex ? .blue : .primary) // highlight the button
                
            }
        }
    }
}

struct CategoryPicker_Previews: PreviewProvider {
    @State static var selectedCategoryIndex: Int = 1
    static var previews: some View {
        CategoryPicker(categoryList:[.Hotel, .Traffic], selectedCategoryIndex: $selectedCategoryIndex)
    }
}
