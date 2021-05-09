//
//  TunniplaanFunc.swift
//  OIS
//
//  Created by User on 10.05.2021.
//

import Foundation
import SwiftUI
import SwiftSoup
import WebKit


struct TunniplaanFunc {
    
    func showTunnip() -> ([String], [String], [String], [String], [String], [String]){
        /*let loginURLString = "https://ois2.tlu.ee/tluois/!uus_ois2.ois_public.page?_page=9A46066693F9020547B19035E345EAEE&p_type=ois&p_user=\(username)&p_pwd=\(password)&p_mobiil=big&p_mobiil_tel="
        
        let session = URLSession.shared
        
        guard let loginURL = URL(string: loginURLString) else { return }
        */
        //tryLogin()
        let emptyArr: [String] = []
        var oppejoud: [String] = []
        var ainekood: [String] = []
        var kellAine: [String] = []
        var klass: [String] = []
        var ryhmad: [String] = []
        var tunnid: [String] = []
        let day: Int = Calendar.current.component(.weekday, from: Date())-2
        let tunnipURLString = "https://ois2.tlu.ee/tluois/!uus_ois2.ois_public.page?_page=21D02BFC64FA0CCC52A388D2A2990C7D90419DA7F185EAC00AA85210028D3067&d=\(day)&p_sess=x&p_rnd=1615160982141"
        guard let tunnipURL = URL(string: tunnipURLString) else { return (emptyArr, emptyArr, emptyArr, emptyArr, emptyArr, emptyArr) }
        do {
            let tunnipHTMLString = try! String(contentsOf: tunnipURL, encoding: .utf8)
            //let loginHTMLContent = loginHTMLString
            do {
                let docTunnip: Document = try SwiftSoup.parseBodyFragment(tunnipHTMLString)
                do {
                    let tunnidElem = try! docTunnip.getElementsByClass("large_link2")
                    //var tunnid: [String] = []
                    let ryhmadElem = try! docTunnip.getElementsByTag("span")
                    //var ryhmad: [String] = []
                    let klassElem = try docTunnip.select("div > div > div + div + div + div")
                    //var klass: [String] = []
                    let aineKoodaineOppejoudElem = try docTunnip.select("div > div > div")
                    /*var oppejoud: [String] = []
                    var ainekood: [String] = []
                    var kellAine: [String] = []*/

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
                    
                    /*print (tunnid)
                    print (ryhmad)
                    print (klass)
                    print (ainekood)
                    print (oppejoud)
                    print (kellAine)*/
                    /*TunniPlaanView.fillTunnip(tunnidElem: tunnidElem, ryhmadElem: ryhmadElem, klassElem: klassElem, aineKoodaineOppejoudElem: aineKoodaineOppejoudElem)*/
                    //return tunnid; ryhmad; klass; ainekood; oppejoud; kellAine;
                    //return (tunnid, ryhmad, klass, ainekood, oppejoud, kellAine)
                }
        } catch let error {
            print("Error: \(error)")
        }
    }
        return (tunnid, ryhmad, klass, ainekood, oppejoud, kellAine)
    }
}
