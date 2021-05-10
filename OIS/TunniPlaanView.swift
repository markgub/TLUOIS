//
//  TunniPlaanView.swift
//  OIS
//
//  Created by Vladislav on 12.04.2021.
//

import SwiftUI
import SwiftSoup

struct TunniPlaan: Identifiable {
    var id = UUID()
    var name: String
    var teacher: String
    var time: String
    var place: String
    var groups: String
}

struct TunniPlaanRow: View {
    
    let darkRedColor = Color(red: 0.72, green: 0.07, blue: 0.20)

    let lightGreyColor = Color(red: 0.58, green: 0.59, blue: 0.69)
    
    var course: TunniPlaan
    
    //Specifies the look of each Course struct
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(course.name)
                Text(course.teacher).font(.subheadline).foregroundColor(lightGreyColor)
                Text(course.groups).font(.subheadline).foregroundColor(lightGreyColor)
            }
            Spacer()
            VStack{
                Text(course.time).font(.headline).foregroundColor(darkRedColor)
                Text(course.place)
            }
        }.navigationBarTitle("Tunniplaan")
        .navigationBarBackButtonHidden(true)
    }
}


struct TunniPlaanView: View {
    //Arrays from TunniplaanFunc
    var (tunnid, ryhmad, klass, oppejoud, ainekood, kellAine) = TunniplaanFunc().showTunnip()

    func latestValue() -> [TunniPlaan]{
        /*var latestgrades: [Course] = [Course(name: tunnid[0], teacher: oppejoud[0], grade: "B")]*/
        var latestgrades: [TunniPlaan] = []
        var i = 0
        for _ in tunnid{
            latestgrades.append(TunniPlaan(name: tunnid[i], teacher: oppejoud[i], time: kellAine[i], place: klass[i], groups: ryhmad[i]))
            i += 1
        }
        
        return latestgrades
    }
    
    //var i: int;
    var body: some View {
        if(!tunnid.isEmpty){
            List {
                Section(header: TunniplaanHeader(), footer: TunniplaanFooter()) {
                    ForEach(latestValue()) { course in
                        TunniPlaanRow(course: course)
                    }
                }
            }.listStyle(GroupedListStyle())
        } else {
            Text("Tunnid puuduvad")
        }
        NavBar()
    }
}

struct TunniplaanHeader: View {
    var body: some View {
        HStack {
            Text("Täna on ")
        }
    }
}

struct TunniplaanFooter: View {
    var body: some View {
        Text("")
    }
}

/*struct TunniPlaanView_Previews: PreviewProvider {
    @State var testtest: [String] = []
    static var previews: some View {
        TunniPlaanView(/*tunnid: $testtest, ryhmad: $testtest, klass: $testtest, oppejoud: $testtest, ainekood: $testtest, kellAine: $testtest*/)
    }
}*/
