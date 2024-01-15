//
//  CustomButtonText.swift
//  My Wallet
//
//  Created by Moha Maanka on 1/7/24.
//

import SwiftUI

struct CustomButtonText: View {
    var title : String
    var body: some View {
        Text(title)
            .frame(width: 360, height: 55)
            .background(Color.kPrimary)
            .foregroundColor(.white)
            .fontWeight(.semibold)
            .cornerRadius(15)
            .padding(.bottom, 20)
            .font(.title2)
    }
}

#Preview {
    CustomButtonText(title: "hello")
}
