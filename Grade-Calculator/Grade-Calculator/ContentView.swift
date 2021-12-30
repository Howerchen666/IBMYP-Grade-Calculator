//
//  ContentView.swift
//  Grade-Calculator
//
//  Created by Hower Chen on 2020/5/23.
//  Copyright © 2020 Hower Chen. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var selection = 0
    
    @ObservedObject var objects = SubjectObserver()
 
    var body: some View {
        TabView(selection: $selection){
            Overall()
                .environmentObject(objects)
                .font(.title)
                .tabItem {
                    VStack {
                        Image(systemName: "chart.bar")
                        Text("OverView")
                    }
                }
                .tag(0)
            Edit()
                .environmentObject(objects)
                .font(.title)
                .tabItem {
                    VStack {
                        Image(systemName: "pencil.tip")
                        Text("Grade Editor")
                    }
                }
                .tag(1)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
