//
//  TunniPlaanView.swift
//  OIS
//
//  Created by Vladislav on 12.04.2021.
//

import SwiftUI

struct TunniPlaan: Identifiable {
    var id = UUID()
    var name: String
    var teacher: String
    var time: String
    var place: String
    var nameCode: String
}

struct TunniPlaanRow: View {
    
    let darkRedColor = Color(red: 0.72, green: 0.07, blue: 0.20)

    let lightGreyColor = Color(red: 0.58, green: 0.59, blue: 0.69)
    
    var course: Course
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(course.name)
                Text(course.teacher).font(.subheadline).foregroundColor(lightGreyColor)
            }
            Spacer()
            Text(course.grade).font(.headline).foregroundColor(darkRedColor)
        }
    }
}


struct TunniPlaanView: View {
    let latestgrades = [
        Course(name: "Intellektuaalne omand ja andmekaitse", teacher: "Tanel Õunapuu", grade: "A"),
        Course(name: "Arvutigraafika", teacher: "Mati Mõttus    ", grade: "B"),
        Course(name: "Rakenduste programmeerimine", teacher: "Romil Rõbtšenkov", grade: "A"),
        Course(name: "Teoreetiline informaatika", teacher: "Peeter Normak    ", grade: "C"),
        Course(name: "Diskreetse matemaatika elemendid", teacher: "Tatjana Tamberg", grade: "B"),
    ]
    
    var body: some View {
        List {
            Section(header: TunniplaanHeader(), footer: TunniplaanFooter()) {
                ForEach(latestgrades) { course in
                    CourseRow(course: course)
                }
            }
        }.listStyle(GroupedListStyle())
    }
}

struct TunniplaanHeader: View {
    var body: some View {
        HStack {
            //Image(systemName: "star")
            Text("Täna on ")
        }
    }
}

struct TunniplaanFooter: View {
    var body: some View {
        Text("Täna on ")
    }
}

struct TunniPlaanView_Previews: PreviewProvider {
    static var previews: some View {
        TunniPlaanView()
    }
}
