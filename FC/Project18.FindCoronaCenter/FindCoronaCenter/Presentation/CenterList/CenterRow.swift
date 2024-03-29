//
//  CenterRow.swift
//  FindCoronaCenter
//
//  Created by 이진희 on 2022/09/28.
//

import SwiftUI

struct CenterRow: View {
    var center: Center
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(center.facilityName)
                    .font(.headline)
                Text(center.centerType.rawValue)
                    .font(.caption)
                    .foregroundColor(.gray)
                Spacer()
            }
            Text(center.address)
                .font(.footnote)
            
            //if let url = URL(string: "tel:" + //center.phoneNumber) {
                //Link(center.phoneNumber, destination: url)
            //}
        }
        .padding()
    }
}

struct CenterRow_Previews: PreviewProvider {
    static var previews: some View {
        let center0 = Center(id: 0, sido: .경기도, facilityName: "실내빙상장 앞", address: "경기도 진희시 진희구", lat: "37.404476", lng: "126.9491998", centerType: .central, phoneNumber: "010-0000-0000")
        CenterRow(center: center0)
    }
}
