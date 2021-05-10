//
//  StudyPlanFunc.swift
//  OIS
//


import Foundation
import SwiftUI
import SwiftSoup
import WebKit

struct StudyPlanFunc {
    
    //Function that will return information from study plan page
    func getStudyPlan() -> ([String],[String],[String],[String],[String],[String],[String],[String], [String], [String], [String]){
        //URL of study plan page
        let myURLString = "https://ois2.tlu.ee/tluois/!uus_ois2.ois_public.page?_page=F16F063C4A9AC776422AF6B549C592D0A719926CC31E3BA70301224C95CEF98E"
        //Empty array that is going to replace all arrays in case of error
        let emptyArr: [String] = []
        guard let myURL = URL(string: myURLString) else {return(emptyArr, emptyArr, emptyArr, emptyArr, emptyArr, emptyArr, emptyArr, emptyArr, emptyArr, emptyArr, emptyArr)}
        
        //Arrays that are going to contain information for the courses in the study plan
        var names: [String] = []
        var languages: [String] = []
        var teachers: [String] = []
        var status: [String] = []
        var modules: [String] = []
        var EAP: [String] = []
        var prices: [String] = []
        var prerequisites: [String] = []
        var until: [String] = []
        var secondListenings: [String] = []
        var total: [String] = []
        do {
            //New constant that will hold the contents of page
            let contents = try String(contentsOf: myURL)
            do {
                let docMain: Document = try SwiftSoup.parseBodyFragment(contents)
                
                //Fetch the contents of div with an id="esivorm21"
                let valge: Elements = try docMain.getElementsByClass("valge") //We select only
                let kokku: Elements = try docMain.getElementsByClass("kokku").select("div > div > div")
                var i = 0
                
                //The following array is sorting elements into their corresponding arrays as strings
                i = 0
                for element in valge{
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
                }
                
                for element in kokku {
                    total.append(try! element.text())
                }
                //print(try! valge.text())
                /*i = 0
                for _ in total{
                    print(total[i])
                    print(i)
                    i += 1
                }*/
            } catch let error {
                print("Error: \(error)")
            }
        } catch let error {
            print("Error: \(error)")
        }
        //Returns the arrays
        return (names, languages, teachers, status, modules, EAP, prices, prerequisites, until, secondListenings, total)
    }
}
