//
//  LessonsShortView.swift
//  OIS
//

import SwiftUI

//Struct that will hold information about a lesson from study plan
struct Lesson: Identifiable {
    var id = UUID()
    var name: String
    var teacher: String
    var language: String
    var status: String
    var eap: String
    var second: String
    var eeldus: String
    var module: String
    var price: String
    var date: String
}

//The struct that will act as a container with right design for each lesson struct
struct LessonRow: View {
    
    let darkRedColor = Color(red: 0.72, green: 0.07, blue: 0.20)

    let lightGreyColor = Color(red: 0.58, green: 0.59, blue: 0.69)
    
    var lesson: Lesson
    
    //Here we establish the outlook of LessonRow
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(lesson.name)
                Text("\(lesson.language), ").font(.subheadline).foregroundColor(lightGreyColor)
                Text(lesson.module).font(.subheadline).foregroundColor(lightGreyColor)
            }
            Spacer()
            Text(lesson.teacher)
            VStack{
                Text(lesson.eap).font(.headline).foregroundColor(darkRedColor)
                Text(lesson.price).font(.subheadline)
            }
        }.navigationBarTitle("Õpingukava")
        .navigationBarBackButtonHidden(true)
    }
}

struct LessonsShortView: View {
    //Here we receive arrays from StudyPlanFUnc that contain information from study plan page
    var (names, languages, teachers, status, modules, EAP, prices, prerequisites, until, secondListenings, total) = StudyPlanFunc().getStudyPlan()
    
    //This function is going to create a massive consisting of lessons filled from StudyPlanFunc
    func latestValue() -> [Lesson]{
        var latestgrades: [Lesson] = []
        var i = 0
        //For cycle that creates structs lessons
        for _ in names{
            latestgrades.append(Lesson(name: names[i], teacher: teachers[i], language: languages[i], status: status[i], eap: EAP[i], second: secondListenings[i], eeldus: prerequisites[i], module: modules[i], price: prices[i], date: until[i]))
            i += 1
        }
        return latestgrades
    }
    var body: some View {
        List {
            Section(header: ListHeader(), footer: ListFooter(total: total[0], totalPrice: total[1])) {
                ForEach(latestValue()) { lesson in
                    LessonRow(lesson: lesson)
                }
            }
        }.listStyle(GroupedListStyle())
        NavBar()
    }
}



struct ListHeader: View {
    var body: some View {
        HStack {
            Image(systemName: "eyeglasses")
            Text("Õpingukavas olevad ained:")
        }
    }
}

struct ListFooter: View {
    var total: String, totalPrice:String
    var body: some View {
        Text("Kokku: \(total) | \(totalPrice)")
    }
    
}

struct LessonsShortView_Previews: PreviewProvider {
    static var previews: some View {
        LessonsShortView()
    }
}
