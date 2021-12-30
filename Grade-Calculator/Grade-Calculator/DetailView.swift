//
//  DetailView.swift
//  Grade-Calculator
//
//  Created by Hower Chen on 2020/5/23.
//  Copyright © 2020 Hower Chen. All rights reserved.
//

import SwiftUI

struct DetailView: View {
    
    @Binding var subject: SubjectInfo
    
    var aBinding: Binding<String> {
        return Binding(get: {
            return "\(self.subject.A)"
        }, set: { newValue in
            if !newValue.isEmpty {
                self.subject.A = Int(newValue) ?? 0
            }
        })
    }
    
    var bBinding: Binding<String> {
        return Binding(get: {
            return "\(self.subject.B)"
        }, set: { newValue in
            if !newValue.isEmpty {
                self.subject.B = Int(newValue) ?? 0
            }
        })
    }
    
    var cBinding: Binding<String> {
        return Binding(get: {
            return "\(self.subject.C)"
        }, set: { newValue in
            if !newValue.isEmpty {
                self.subject.C = Int(newValue) ?? 0
            }
        })
    }
    
    var dBinding: Binding<String> {
        return Binding(get: {
            return "\(self.subject.D)"
        }, set: { newValue in
            if !newValue.isEmpty {
                self.subject.D = Int(newValue) ?? 0
            }
        })
    }
    
    var body: some View {

        VStack(alignment: .leading, spacing: 12.0) {
            HStack {
                Text("Subject Name:")
                TextField("Enter Your Subject Name", text: $subject.Subject)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            HStack {
                Text("Criteria A Grade:")
                TextField("Enter Your Criteria A Grade", text: aBinding)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            HStack {
                Text("Criteria B Grade:")
                TextField("Enter Your Criteria B Grade", text: bBinding)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            HStack {
                Text("Criteria C Grade:")
                TextField("Enter Your Criteria C Grade", text: cBinding)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            HStack {
                Text("Criteria D Grade:")
                TextField("Enter Your Criteria D Grade", text: dBinding)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            }
        }
        .padding(.horizontal, 15.0)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(subject: .constant(SubjectInfo(subject: "Chinese", A: 5, B: 4, C: 3, D: 2)))
    }
}
