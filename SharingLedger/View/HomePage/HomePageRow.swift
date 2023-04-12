//
//  HomePageRow.swift
//  SharingLedger
//
//  Created by mac on 2023/4/6.
//

import SwiftUI

struct HomePageRow: View {
    var body: some View {
        VStack{
            HStack{
                Spacer()
                Text("created at 2023-3-1 01:19:21").font(.custom("Inter Light", size: 10)).multilineTextAlignment(.trailing)
                    .offset(x: -30)
            }
            ZStack{
                Rectangle()
                    .fill(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                    .frame(width: 332, height: 133)
                    .shadow(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.25)), radius:4, x:0, y:4)
                VStack{
                    Text("Alaska").font(.custom("Inter Bold", size: 14)).multilineTextAlignment(.center)
                    
                    HStack{
                        
                        SmallCircleImage(image: Image("Unknown"), width: 35, height: 35, shadowRadius: 0)
                        SmallCircleImage(image: Image("Unknown"), width: 35, height: 35, shadowRadius: 0)
                        SmallCircleImage(image: Image("Unknown"), width: 35, height: 35, shadowRadius: 0)
                        SmallCircleImage(image: Image("Unknown"), width: 35, height: 35, shadowRadius: 0)
                        
                        Text("...").font(.custom("Inter Bold", size: 14)).multilineTextAlignment(.center)
                        
                        Circle()
                            .fill(Color(#colorLiteral(red: 0.1585937738418579, green: 0.7221303582191467, blue: 0.8458333611488342, alpha: 1)))
                        .frame(width: 40, height: 40)
                        
                        
                    }
                    
                    Divider()
                        .frame(width: 310)
                    HStack{
                        Spacer()
                        
                        Text("my payment  US$ 2500.1").font(.custom("Inter Bold", size: 10)).multilineTextAlignment(.center)
                            .offset(x:-40)
                    }
                }
                
            }
            
        }
    }
}

struct HomePageRow_Previews: PreviewProvider {
    static var previews: some View {
        HomePageRow()
    }
}
