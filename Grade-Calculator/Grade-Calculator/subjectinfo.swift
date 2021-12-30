//
//  PlaneInfo.swift
//  planeTracker
//
//  Created by Hower Chen on 2020/5/20.
//  Copyright © 2020 Hower Chen. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

func loadsubjectInfo() -> [SubjectInfo] {
    let subjectJSONURL = AppDelegate.getDocumentsDirectory().appendingPathComponent("grades.json")
    let content = try? Data(contentsOf: subjectJSONURL)
    if content == nil {
        // Error
        return []
    }
    
    do {
        let allSubjectInfo = try JSONDecoder().decode([SubjectInfo].self, from: content!)
        return allSubjectInfo
    } catch {
        print("\(error)")
        return []
    }
}

final class SubjectObserver: ObservableObject {
    @Published var allSubjects: [SubjectInfo]
    
    var averageGrade: Double {
        Double(allSubjects.map({ subject in
            return subject.subjectGrade
        }).reduce(0, +)) / Double(allSubjects.count)
    }
    
    var notificationSubscriber: AnyCancellable?
    
    init() {
        allSubjects = loadsubjectInfo()
        
        self.notificationSubscriber = NotificationCenter.default.publisher(for: UIApplication.willTerminateNotification)
            .sink { _ in
                self.saveData()
        }

    }
    
    func saveData() {
        let data: Data
        do {
            data = try JSONEncoder().encode(allSubjects)
        } catch {
            print("Error: \(error)")
            return
        }
        
        let writePath = AppDelegate.getDocumentsDirectory().appendingPathComponent("grades.json")
        do {
            try data.write(to: writePath)
        } catch {
            print("\(error)")
        }
    }
    
    func getScoreTuple() -> [(String, Int)] {
        return self.allSubjects.map { subject in
            return (subject.Subject, subject.subjectGrade)
        }
    }
}

struct SubjectInfo: Codable, Identifiable {
    let id = UUID()
    
    var Subject: String
    var A: Int {
        didSet {
            print("A set")
        }
    }
    var B: Int {
        didSet {
            
        }
    }
    var C: Int {
        didSet {
            
        }
    }
    var D: Int {
        didSet {
            
        }
    }
    
    init(subject: String, A: Int, B: Int, C: Int, D: Int) {
        self.Subject = subject
        self.A = A
        self.B = B
        self.C = C
        self.D = D
    }
    
    
    var subjectGrade : Int{
        if sum <= 5{
            return 1
        }
        else if sum <= 9 && sum >= 6 {
            return 2
        }
        else if sum <= 14 && sum >= 10 {
            return 3
        }
        else if sum <= 18 && sum >= 15 {
            return 4
        }
        else if sum <= 23 && sum >= 19 {
            return 5
        }
        else if sum <= 27 && sum >= 24 {
            return 6
        }
        else {
            return 7
        }
    }
    var sum : Int{
        return A + B + C + D
    }
    
}
