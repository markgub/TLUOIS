//
//  NavBar.swift
//  OIS
//


import Foundation
import SwiftUI

//This struct creates navigation menu at the bottom of the screen
struct NavBar: View{
    let tabBarImageNames = ["list.bullet.rectangle", "calendar.badge.clock", "eyeglasses", "star"] //icon names
    var body: some View {
        VStack(alignment: .leading){
            Spacer().frame(maxWidth: .infinity)
            HStack(alignment: .bottom){
                Spacer()
                //Link to "Main page"
                NavigationLink(
                    destination: MainPageView(),
                    label: {
                        Image(systemName: tabBarImageNames[0])
                            .font(.system(size: 25, weight: .bold))
                            .foregroundColor(darkRedColor)
                    })
                Spacer()
                //Link to study schedule
                NavigationLink(
                    destination: TunniPlaanView(),
                    label: {
                        Image(systemName: tabBarImageNames[1])
                            .font(.system(size: 25, weight: .bold))
                            .foregroundColor(darkRedColor)
                    })
                Spacer()
                //Link to study plan
                NavigationLink(
                    destination: LessonsShortView(),
                    label: {
                        Image(systemName: tabBarImageNames[2])
                            .font(.system(size: 25, weight: .bold))
                            .foregroundColor(darkRedColor)
                            .frame(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    })
                Spacer()
                //Link to all grades
                NavigationLink(
                    destination: LatestGradesView(),
                    label: {
                        Image(systemName: tabBarImageNames[3])
                            .font(.system(size: 25, weight: .bold))
                            .foregroundColor(darkRedColor)
                    })
                Spacer()
            }
        }.frame(maxHeight: 50) //Makes sure that navigation bar wont take too much room
    }
}
