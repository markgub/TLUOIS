//
//  LatestGradesView.swift
//  OIS
//
//  Created by root user on 15.03.2021.
//

import SwiftUI

struct Course: Identifiable {
    var id = UUID()
    var name: String
    var teacher: String
    var EAP: String
    var kv: String
    var grade: String
    var date: String
    var code: String
    var ok: String
}

struct CourseRow: View {
    
    let darkRedColor = Color(red: 0.72, green: 0.07, blue: 0.20)

    let lightGreyColor = Color(red: 0.58, green: 0.59, blue: 0.69)
    
    var course: Course
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(course.name)
                HStack{
                    Text(course.teacher).font(.subheadline).foregroundColor(lightGreyColor)
                    Text(course.date).font(.subheadline).foregroundColor(lightGreyColor)
                }
            }
            Spacer()
            HStack{
                Text(course.grade).font(.headline).foregroundColor(darkRedColor)
                Text(course.ok)
            }
            .navigationBarTitle("")
            .navigationBarBackButtonHidden(true)
        }
    }
}


struct LatestGradesView: View {
    
    //@Binding var tunnid: String
    
    /*let latestgrades = [
        Course(name: "Mingi tund", teacher: "Tanel Õunapuu", grade: "A"),
        Course(name: "Arvutigraafika", teacher: "Mati Mõttus    ", grade: "B"),
        Course(name: "Rakenduste programmeerimine", teacher: "Romil Rõbtšenkov", grade: "A"),
        Course(name: "Teoreetiline informaatika", teacher: "Peeter Normak    ", grade: "C"),
        Course(name: "Diskreetse matemaatika elemendid", teacher: "Tatjana Tamberg", grade: "B"),
    ]*/
    var (names, codes, teachers, EAP, semester, grades, dates, completed, comments, totalKKH) = GradesFunc().getGrades()
    
    //This function is going to create a massive consisting of courses from GradesFunc
    func latestValue() -> [Course]{
        var latestgrades: [Course] = []
        var i = 0
        var newCompleted: String
        let size = names.count - 1
        for _ in names{
            if(completed[size-i] == "jah"){
                newCompleted = "Korras"
            } else if (completed[size-i] == "ei"){
                newCompleted = "Pole korras"
            } else {
                newCompleted = completed[size-i]
            }
            latestgrades.append(Course(name: names[size-i], teacher: teachers[size-i], EAP: EAP[size-i], kv: semester[size-i], grade: grades[size-i], date: dates[size-i], code: codes[size-i], ok: newCompleted))
            i += 1
        }
        
        return latestgrades
    }
    var body: some View {
        List {
            Section(header: LatestGradesListHeader(), footer:LatestGradesListFooter(total: totalKKH[0], KKH: totalKKH[1])) {
                ForEach(latestValue()) { course in
                    CourseRow(course: course)
                }
            }
        }.listStyle(GroupedListStyle())
    NavBar()
    }
    
}

struct LatestGradesListHeader: View {
    var body: some View {
        HStack {
            Image(systemName: "star")
            Text("Koik hinded ja arvestused")
        }
    }
}

struct LatestGradesListFooter: View {
    var total:String
    var KKH:String
    var body: some View {
        Text(total).font(.subheadline)
        Text(KKH).font(.subheadline)
    }
}


struct LatestGradesView_Previews: PreviewProvider {
    static var previews: some View {
        LatestGradesView()
    }
}
