//
//  SwiftUIView.swift
//  OIS
//
//  Created by root user on 14.03.2021.
//

import SwiftUI

struct StudyPlanCourse: Identifiable {
    var id = UUID()
    var name:String
    var code:String
    var EAP:String
}

struct StudyPlanRow: View {
    
    let darkRedColor = Color(red: 0.72, green: 0.07, blue: 0.20)

    let lightGreyColor = Color(red: 0.58, green: 0.59, blue: 0.69)
    
    var course: StudyPlanCourse
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(course.name)
                Text(course.code).font(.subheadline).foregroundColor(lightGreyColor)
            }
            Spacer()
            VStack{
                Text(course.EAP).font(.headline).foregroundColor(darkRedColor)
            }
        }.navigationBarTitle("Avaleht")
        .navigationBarBackButtonHidden(true)
    }
}
struct MainPageView: View {
    
    var (planNames, planCodes, planEAP, gradesDates, gradesGrades, gradesName, gradesTeachers, gradesEAP) = ExperimentFunc().getMainPage()
    
    
    func latestValue() -> [StudyPlanCourse]{
        var latestgrades: [StudyPlanCourse] = []
        var i = 0
        for _ in planNames{
            latestgrades.append(StudyPlanCourse(name: planNames[i], code: planCodes[i], EAP: planEAP[i]))
            i += 1
        }
        
        return latestgrades
    }
    
    //var i: int;
    var body: some View {
        if(!planNames.isEmpty){
            List {
                Section(header: StudyPlaanHeader(), footer: StudyPlaanFooter()) {
                    ForEach(latestValue()) { course in
                        StudyPlanRow(course: course)
                    }
                }
            }.listStyle(GroupedListStyle())
        } else {
            Text("Opingukava puudub")
        }
        Button(action: {GradesFunc().getGrades()}, label: {
            Text("Test StudyPlan Func")
        })
    }
}


struct StudyPlaanHeader: View {
    var body: some View {
        HStack {
            //Image(systemName: "star")
            Text("OPINGUKAVA(ESITATUD)")
        }
    }
}

struct StudyPlaanFooter: View {
    var body: some View {
        Text("")
    }
}
struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        MainPageView()
    }
}
