//
//  GradesFunc.swift
//  OIS
//
//  Created by User on 09.05.2021.
//

import Foundation
import SwiftUI
import SwiftSoup
import WebKit

struct GradesFunc {
    
    //Function that will return information from student performance grades
    func getGrades() -> ([String],[String],[String],[String],[String],[String],[String],[String], [String], [String]){
        //URL of study plan page
        let myURLString = "https://ois2.tlu.ee/tluois/!uus_ois2.ois_public.page?_page=413332E484BE8E40EAC2321AB27965E8ABD5B1365AB47F36C0F47963964F1D38CAD7DB9C7B3DA80A&p_rnd=1620563314520"
        //Empty array that is going to replace all arrays in case of error
        let emptyArr: [String] = []
        guard let myURL = URL(string: myURLString) else {return(emptyArr, emptyArr, emptyArr, emptyArr, emptyArr, emptyArr, emptyArr, emptyArr, emptyArr, emptyArr)}
        
        //Arrays that are going to contain information for the courses in the study plan
        var names: [String] = []
        var codes: [String] = []
        var EAP: [String] = []
        var semester: [String] = []
        var grades: [String] = []
        var dates: [String] = []
        var teachers: [String] = []
        var completed: [String] = []
        var comments: [String] = []
        var secondListenings: [String] = []
        do {
            //New constant that will hold the contents of page
            let contents = try String(contentsOf: myURL)
            do {
                let docMain: Document = try SwiftSoup.parseBodyFragment(contents)
                
                //Fetch the needed div
                let list: Elements = try docMain.getElementsByClass("yldandmed2 ot_sem").select("div > div + div + div > div")
                var i = 0
                
                //The following array is sorting elements into their corresponding arrays as strings
                i = 0
                /*for element in valge{
                    switch i {
                    case 0:
                        names.append(try! element.select("div > div").first()!.text())
                        languages.append(try! element.select("div + div").text())
                        i += 1
                    case 1:
                        teachers.append(try! element.text())
                        i += 1
                    case 2:
                        status.append(try! element.select("div > div").first()!.text())
                        modules.append(try! element.select("div + div").text())
                        i += 1
                    case 3:
                        EAP.append(try! element.select("div > div").first()!.text())
                        prices.append(try! element.select("div + div").text())
                        i += 1
                    case 4:
                        prerequisites.append(try! element.text())
                        i += 1
                    default:
                        until.append(try! element.select("div > div > div").first()!.text())
                        secondListenings.append(try! element.select("div + div").text())
                        i = 0
                    }
                }*/
                //print(try! valge.text())
                //i = 0
                /*for _ in names{
                    print(names[i])
                    print(languages[i])
                    print(teachers[i])
                    print(status[i])
                    print(modules[i])
                    print(EAP[i])
                    print(prices[i])
                    print(prerequisites[i])
                    print(until[i])
                    print(secondListenings[i])
                    i += 1
                }*/
                print(try! list.text())
            } catch let error {
                print("Error: \(error)")
            }
        } catch let error {
            print("Error: \(error)")
        }
        //Returns the arrays
        return (emptyArr, emptyArr, emptyArr, emptyArr, emptyArr, emptyArr, emptyArr, emptyArr, emptyArr, emptyArr)
    }
}
