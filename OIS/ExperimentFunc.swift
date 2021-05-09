//
//  ExperimentFunc.swift
//  OIS
//
//  Created by Mark-Kirill Gubal on 25.04.2021.
//

import Foundation
import SwiftUI
import SwiftSoup
import WebKit

struct ExperimentFunc {
    
    func getMainPage() -> ([String],[String],[String],[String],[String],[String],[String],[String]){
        //URL of main page
        let myURLString = "https://ois2.tlu.ee/tluois/!uus_ois2.ois_public.page?_page=413332E484BE8E405928509CC8823271CB8D8439E6FAACB6796840DCFFC61206"
        //Empty array that is going to replace all arrays in case of error
        let empryArr: [String] = []
        guard let myURL = URL(string: myURLString) else {return(empryArr, empryArr, empryArr, empryArr, empryArr, empryArr, empryArr, empryArr)}
        
        //Arrays for the information about current study plan
        var esivorm21EAP: [String] = []
        var esivorm21Names: [String] = []
        var esivorm21Codes: [String] = []
        var i = 0
        
        //Arrays that are going to contain information for latest grades
        var esivorm22Teachers: [String] = []
        var esivorm22Dates: [String] = []
        var esivorm22EAP: [String] = []
        var esivorm22Names: [String] = []
        var esivorm22Grades: [String] = []
        do {
            let contents = try String(contentsOf: myURL)
            do {
                let docMain: Document = try SwiftSoup.parseBodyFragment(contents)
                
                //Fetch the contents of div with an id="esivorm21"
                let esivorm21: Elements = try docMain.select("[id=esivorm21]").select("div:not([class])") //We avoi fetching total amount of EAPs with pseudo selecter div:not
                let esivorm21a: Elements = try esivorm21.select("a") //Here we get course name
                let esivorm21b: Elements = try esivorm21.select("span") //Here we get course codes
                
                //The next 3 for cycles are going to sort all the elements into their respective arrays as strigns
                for element in esivorm21{
                    if(i%3 == 0 && i != 0){
                        esivorm21EAP.append(try! element.text())
                    }
                    i += 1
                }
                i = 0
                for element in esivorm21a{
                    esivorm21Names.append(try! element.text())
                }
                i = 0
                for element in esivorm21b{
                    esivorm21Codes.append(try! element.text())
                }
                
                //Here we select only div-s with that contain no other div-s
                let esivorm22: Elements = try docMain.select("[id=esivorm22]").select("div > div > div:not([class])")
        
                //The next for cycle is going to sort the elements of esivorm22 to their corresponding arrays as strings
                i = 0
                for element in esivorm22{
                    switch i {
                    case 0:
                        esivorm22Dates.append(try! element.text())
                        i += 1
                    case 1:
                        esivorm22Grades.append(try! element.text())
                        i += 1
                    case 2:
                        esivorm22Names.append(try! element.text())
                        i += 1
                    case 3:
                        esivorm22Teachers.append(try! element.text())
                        i += 1
                    default:
                        esivorm22EAP.append(try! element.text())
                        i = 0
                    }
                }
            } catch let error {
                print("Error: \(error)")
            }
        } catch let error {
            print("Error: \(error)")
        }
        return (esivorm21Names, esivorm21Codes, esivorm21EAP, esivorm22Dates, esivorm22Grades, esivorm22Names, esivorm22Teachers, esivorm22EAP)
    }
}
