//
//  NavBar.swift
//  OIS
//
//  Created by User on 10.05.2021.
//

import Foundation
import SwiftUI

struct NavBar: View{
    let tabBarImageNames = ["list.bullet.rectangle", "calendar.badge.clock", "eyeglasses", "star"]
    @State private var currentTab = 0
    var body: some View {
        VStack(alignment: .leading){
            Spacer().frame(maxWidth: .infinity)
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
                            .frame(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
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
        }.frame(maxHeight: 50)
    }
}
