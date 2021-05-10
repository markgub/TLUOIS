//
//  SwiftUIView.swift
//  OIS
//


import SwiftUI

//Struct for study plan courses
struct StudyPlanCourse: Identifiable {
    var id = UUID()
    var name:String
    var code:String
    var EAP:String
}

//Struct for latest grades
struct latestGrade: Identifiable {
    var id = UUID()
    var date: String
    var name: String
    var teacher: String
    var grade: String
    var EAP: String
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

struct latestGradeRow: View{
    let darkRedColor = Color(red: 0.72, green: 0.07, blue: 0.20)

    let lightGreyColor = Color(red: 0.58, green: 0.59, blue: 0.69)
    
    var course: latestGrade
    
    //Sets the apperance of each row
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(course.name)
                Text("\(course.teacher), \(course.date)").font(.subheadline).foregroundColor(lightGreyColor)
            }
            Spacer()
            VStack{
                Text(course.grade).font(.headline).foregroundColor(darkRedColor)
            }
            Text(course.EAP)
        }.navigationBarTitle("Avaleht")
        .navigationBarBackButtonHidden(true)
    }}
struct MainPageView: View {
    //Arrays that we receive from ExperimentFunc. They contain information about study plan and the grades
    var (planNames, planCodes, planEAP, gradesDates, gradesGrades, gradesNames, gradesTeachers, gradesEAP) = ExperimentFunc().getMainPage()
    
    //Returns arrays consisting of StudyPlanCourse structs
    func latestValue() -> [StudyPlanCourse]{
        var latestgrades: [StudyPlanCourse] = []
        var i = 0
        for _ in planNames{
            latestgrades.append(StudyPlanCourse(name: planNames[i], code: planCodes[i], EAP: planEAP[i]))
            i += 1
        }
        
        return latestgrades
    }
    
    //Returns arrays consisting of StudyPlanCourse structs
    func latestGrades() -> [latestGrade]{
        var latestgrades: [latestGrade] = []
        var i = 0
        for _ in gradesNames{
            latestgrades.append(latestGrade(date: gradesDates[i], name: gradesNames[i], teacher: gradesTeachers[i], grade: gradesGrades[i], EAP: gradesEAP[i]))
            i += 1
        }
        
        return latestgrades
    }
    //var i: int;
    var body: some View {
        if(!planNames.isEmpty){
            List {
                Section(header: StudyPlaanHeader()) {
                    ForEach(latestValue()) { course in
                        StudyPlanRow(course: course)
                    }
                }
            }.listStyle(GroupedListStyle())
        } else {
            Text("Õpingukava puudub")
        }
        if(gradesNames.isEmpty){
            Text("Viimased hinded puuduvad")
        } else {
            List{
                Section(header: latestGradesHeader()){
                    ForEach(latestGrades()) { course in
                        latestGradeRow(course: course)
                    }
                }
            }.listStyle(GroupedListStyle())
        }
        NavBar()
    }
}


struct StudyPlaanHeader: View {
    var body: some View {
        HStack {
            Image(systemName: "eyeglasses")
            Text("Õpingukava(ESITATUD)")
        }
    }
}

struct latestGradesHeader: View {
    var body: some View {
        HStack {
            Image(systemName: "star")
            Text("Viimased hinded")
        }
    }
}
struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        MainPageView()
    }
}
