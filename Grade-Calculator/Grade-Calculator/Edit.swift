//
//  Edit.swift
//  Grade-Calculator
//
//  Created by Hower Chen on 2020/5/23.
//  Copyright © 2020 Hower Chen. All rights reserved.
//

import SwiftUI
import Combine

struct Edit: View {
    @State var Subjects = loadsubjectInfo()
    
    @State var notificationSubscriber: AnyCancellable?
    @EnvironmentObject var objects: SubjectObserver
    @State var newSubjectName:String = ""
    @State var settingName = false
    
    var body: some View { 
        NavigationView {
            List {
                Section(header: Text("Enter or edit your grade here")) {
                    ForEach(objects.allSubjects.indices, id: \.self) { index in
                        NavigationLink(destination: DetailView(subject: self.createBindingFor(index))) {
                            Text(self.objects.allSubjects[index].Subject)
                        }
                    }.onDelete(perform: self.deleteListItem)
                }
            }
            .font(.body)
            .navigationBarTitle("Grade Editor")
            .navigationBarItems(trailing: Button(action: {
                self.settingName = true
            }) {
                Image(systemName: "plus")
                    .font(.title)
            }
            .sheet(isPresented: $settingName) {
                AddName(newSubjectName: self.newSubjectName, Subjects: self.$objects.allSubjects)
            })
        }
        
    }
    
    func createBindingFor(_ index: Int) -> Binding<SubjectInfo> {
        Binding(get: {
            self.objects.allSubjects[index]
        }) { newValue in
            self.objects.allSubjects[index] = newValue
        }
    }
    
    func deleteListItem(whichElement: IndexSet) {
        objects.allSubjects.remove(atOffsets: whichElement)
    }
    
    func saveData() {
        let data: Data
        do {
            data = try JSONEncoder().encode(Subjects)
        } catch {
            print("Error: \(error)")
            return
        }
        print("Save Data!!!!!!!!!!!!!!!!!!!")
        
        let writePath = AppDelegate.getDocumentsDirectory().appendingPathComponent("grades.json")
        do {
            try data.write(to: writePath)
        } catch {
            print("\(error)")
        }
    }
}

struct Edit_Previews: PreviewProvider {
    static var previews: some View {
        Edit()
    }
}

struct AddName: View {
    @State var newSubjectName:String
    @Binding var Subjects:[SubjectInfo]
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            Text("Enter the name of the subject that you want to add!")
            TextField("Name", text:$newSubjectName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Button(action: {
                self.addSubject()
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Text("OK")
            }.disabled(self.newSubjectName.count == 0)
        }
        .padding(.horizontal, 10.0)
    }
    func addSubject(){
        
        let newSubject = SubjectInfo(subject: newSubjectName, A: 0, B: 0, C: 0, D: 0)
        self.Subjects.append(newSubject)
    }
}

