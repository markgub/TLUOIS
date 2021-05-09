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
        /*Button(action: {GradesFunc().getGrades()}, label: {
            Text("Test StudyPlan Func")
        })*/
        /*NavigationLink(
            destination: TunniPlaanView(),
            label: {
                Text("Tunniplaan")
            })*/
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
    let tabBarImageNames = ["list.bullet.rectangle", "calendar.badge.clock", "eyeglasses", "star"]
    var body: some View {
        VStack{
            HStack(alignment: .bottom){
                Spacer()
                NavigationLink(
                    destination: MainPageView(),
                    label: {
                        Image(systemName: tabBarImageNames[0])
                            .font(.system(size: 25, weight: .bold))
                            .foregroundColor(darkRedColor)
                    })
                Spacer()
                NavigationLink(
                    destination: TunniPlaanView(),
                    label: {
                        Image(systemName: tabBarImageNames[1])
                            .font(.system(size: 25, weight: .bold))
                            .foregroundColor(darkRedColor)
                    })
                Spacer()
                NavigationLink(
                    destination: LessonsShortView(),
                    label: {
                        Image(systemName: tabBarImageNames[2])
                            .font(.system(size: 25, weight: .bold))
                            .foregroundColor(darkRedColor)
                    })
                Spacer()
                NavigationLink(
                    destination: LatestGradesView(),
                    label: {
                        Image(systemName: tabBarImageNames[3])
                            .font(.system(size: 25, weight: .bold))
                            .foregroundColor(darkRedColor)
                    })
                Spacer()
            }
        }
    }
}
struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        MainPageView()
    }
}
