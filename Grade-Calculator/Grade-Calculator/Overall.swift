//
//  Overall.swift
//  Grade-Calculator
//
//  Created by Hower Chen on 2020/5/23.
//  Copyright © 2020 Hower Chen. All rights reserved.
//

import SwiftUI

struct Overall: View {
    @EnvironmentObject var objects: SubjectObserver
    
    var body: some View {
        VStack {
            HStack {
                Text("Grade Overview")
                    .font(.title)
                Spacer()
            }
            HStack {
                Text("Check your overall grade here")
                    .font(.subheadline)
                    .foregroundColor(Color.gray)
                Spacer()
            }
            
            Spacer()
            Circle()
            .stroke(Color.blue, lineWidth: 15)
                .frame(width: 250, height: 250)
                .overlay(
                    
                    VStack {
                        Text("\(objects.averageGrade.removeZero)")
                            .font(.largeTitle)
                        Text("Here is your overall grade")
                            .font(.headline)
                })
            Spacer()
            BarChartView(data: ChartData(values: self.objects.getScoreTuple()), title: "Subject Average")
            
            Text("Note: The grade provided is just for reference")
                .foregroundColor(.gray)
                .font(.subheadline)
            Spacer()
        }
        .padding(.horizontal, 12.0)
    }
}

struct Overall_Previews: PreviewProvider {
    static var previews: some View {
        Overall()
    }
}


extension Double {
    var removeZero:String {
        let nf = NumberFormatter()
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 5
        return nf.string(from: NSNumber(value: self))!
    }
}
