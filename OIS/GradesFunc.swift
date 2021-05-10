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
    func getGrades() -> ([String],[String],[String],[String],[String],[String],[String], [String], [String], [String]){
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
        //Array that will store total amount of EAP and KKH
        var totalKKH:[String] = []
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
                for element in list{
                    switch i {
                    case 0:
                        names.append(try! element.text())
                        i += 1
                    case 1:
                        codes.append(try! element.text())
                        i += 1
                    case 2:
                        EAP.append(try! element.text())
                        i += 1
                    case 3:
                        semester.append(try! element.text())
                        i += 1
                    case 4:
                        grades.append(try! element.text())
                        i += 1
                    case 5:
                        dates.append(try! element.text())
                        i += 1
                    case 6:
                        teachers.append(try! element.text())
                        i += 1
                    case 7:
                        completed.append(try! element.text())
                        i += 1
                    default:
                        comments.append(try! element.text())
                        i = 0
                    }
                }
                //Saves total amount of EAP in a dedicated variable and deletes them from arrays names and codes
                totalKKH.append(names[names.count-1])
                names.removeLast()
                totalKKH.append(codes[codes.count-1])
                codes.removeLast()
            }catch let error {
                print("Error: \(error)")
            }
        } catch let error {
            print("Error: \(error)")
        }
        //Returns the arrays
        return (names, codes, teachers, EAP, semester, grades, dates, completed, comments, totalKKH)
    }
}
