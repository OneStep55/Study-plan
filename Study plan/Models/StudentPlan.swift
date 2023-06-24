//
//  StudentPlan.swift
//  Study plan
//
//  Created by Самат Танкеев on 22.06.2023.
//

import Foundation

struct StudentPlan: Codable {
    let iupSid: String
    let title: String
    let documentURL: String
    let academicYearId: String
    let academicYear: String
    let semesters: [Semester]
    
    enum CodingKeys: String, CodingKey {
           case iupSid = "IUPSid"
           case title = "Title"
           case documentURL = "DocumentURL"
           case academicYearId = "AcademicYearId"
           case academicYear = "AcademicYear"
           case semesters = "Semesters"
       }
}

struct Semester: Codable {
    let number: String
    let disciplines: [Discipline]
    
    enum CodingKeys: String, CodingKey {
           case number = "Number"
           case disciplines = "Disciplines"
           
       }
}

struct Discipline: Codable {
    let disciplineId: String
    let disciplineName: DisciplineName
    let lesson: [Lesson]
    
    enum CodingKeys: String, CodingKey {
           case disciplineId = "DisciplineId"
           case disciplineName = "DisciplineName"
           case lesson = "Lesson"
       }
    
}

struct DisciplineName: Codable {
    let nameKk: String
    let nameRu: String
    let nameEn: String
    
    
}

struct Lesson: Codable {
    let lessonTypeId: String
    let hours: String
    let realHours: String
    
    enum CodingKeys: String, CodingKey {
           case lessonTypeId = "LessonTypeId"
           case hours = "Hours"
           case realHours = "RealHours"
       }
}
