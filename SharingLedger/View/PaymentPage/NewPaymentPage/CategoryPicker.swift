//
//  CategoryPicker.swift
//  SharingLedger
//
//  Created by Loaner on 4/3/23.
//

import SwiftUI

struct CategoryPicker: View {
    let categoryList: [Category]
    let categoryNum: Int

    @Binding var selectedCategoryIndex: Int

    var body: some View {
        HStack(spacing: 20) {
            ForEach(0..<categoryNum, id: \.self) { index in
                Button(action: {
                    self.selectedCategoryIndex = index
                }) {
                    VStack{
                        Image(categoryList[index].rawValue)
                            .resizable()
                            .frame(width: 50, height: 50)
                            .colorInvert()
                            .grayscale(index == selectedCategoryIndex ? 0.5 : 1.0)
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
    @State static var selectedCategoryIndex: Int = 0
    static var previews: some View {
        CategoryPicker(categoryList:[.Hotel, .Traffic], categoryNum: 2, selectedCategoryIndex: $selectedCategoryIndex)
    }
}
