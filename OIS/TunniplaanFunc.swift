//
//  TunniplaanFunc.swift
//  OIS
//

import Foundation
import SwiftUI
import SwiftSoup
import WebKit


struct TunniplaanFunc {
    
    func showTunnip() -> ([String], [String], [String], [String], [String], [String]){
        
        //Arrays that will be returned at the end of the function
        let emptyArr: [String] = []
        var oppejoud: [String] = []
        var ainekood: [String] = []
        var kellAine: [String] = []
        var klass: [String] = []
        var ryhmad: [String] = []
        var tunnid: [String] = []
        //This variable specifies the day of lessons
        let day: Int = Calendar.current.component(.weekday, from: Date())-2
        
        //The URL of lesson schedule
        let tunnipURLString = "https://ois2.tlu.ee/tluois/!uus_ois2.ois_public.page?_page=21D02BFC64FA0CCC52A388D2A2990C7D90419DA7F185EAC00AA85210028D3067&d=\(day)&p_sess=x&p_rnd=1615160982141"
        guard let tunnipURL = URL(string: tunnipURLString) else { return (emptyArr, emptyArr, emptyArr, emptyArr, emptyArr, emptyArr) }
        do {
            let tunnipHTMLString = try! String(contentsOf: tunnipURL, encoding: .utf8)
            do {
                //Here we store the HTML code of the page
                let docTunnip: Document = try SwiftSoup.parseBodyFragment(tunnipHTMLString)
                do {
                    //Array that contains course names as Elements
                    let tunnidElem = try! docTunnip.getElementsByClass("large_link2")
                    //Array that contains study groups as Elements
                    let ryhmadElem = try! docTunnip.getElementsByTag("span")
                    //Array that contains studyrooms' names as Elements
                    let klassElem = try docTunnip.select("div > div > div + div + div + div")
                    //Array that contains names of teachers as Elements
                    let aineKoodaineOppejoudElem = try docTunnip.select("div > div > div")

                    //Next 3 for cycles convert data of type Elements to strings and saves them in corresponding arrays
                    for element in tunnidElem{
                        tunnid.append(try! element.text())
                    }
                    
                    for element in ryhmadElem{
                        ryhmad.append(try! element.text())
                    }
                    
                    for element in klassElem{
                        klass.append(try! element.text())
                    }
                    
                    var countInDiv2 = 0
                    //Also convers and saves variables, but also sorts them into rights arrays
                    for element in aineKoodaineOppejoudElem{
                        countInDiv2 += 1
                        if (countInDiv2==1){
                            kellAine.append(try! element.text())
                        }
                        if (countInDiv2==2){
                            ainekood.append(try! element.text())
                        }
                        if (countInDiv2==3){
                            oppejoud.append(try! element.text())
                        }
                        if (countInDiv2 >= 4){
                            countInDiv2 = 0
                        }
                        
                    }

                }
        } catch let error {
            print("Error: \(error)")
        }
    }
        return (tunnid, ryhmad, klass, ainekood, oppejoud, kellAine)
    }
}
