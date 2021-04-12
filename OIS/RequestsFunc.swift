//
//  File.swift
//  OIS
//
//  Created by Vladislav on 16.03.2021.
//

import Foundation
import SwiftUI
import SwiftSoup
import WebKit


struct RequestsFunc {
    
    @Binding var username: String
    @Binding var password: String
    
    @Binding var authenticationDidFail: Bool
    @Binding var authenticationDidSucceed: Bool
    
    @State var tunnid: [String] = []
    
    func tryLogin() {
        let loginURLString = "https://ois2.tlu.ee/tluois/!uus_ois2.ois_public.page?_page=9A46066693F9020547B19035E345EAEE&p_type=ois&p_user=\(username)&p_pwd=\(password)&p_mobiil=big&p_mobiil_tel="
        
        guard let loginURL = URL(string: loginURLString) else { return }
            
        do {
            let loginHTMLString = try! String(contentsOf: loginURL, encoding: .utf8)
            //let loginHTMLContent = loginHTMLString
            do {
                let doc: Document = try SwiftSoup.parse(loginHTMLString)
                do {
                    let loginHTMLParsed = try doc.select("input").first()!
                    
                    let authSuccText = try! loginHTMLParsed.attr("name")
                    
                    //print (authSuccText as Any)
                    
                    if (authSuccText == "p_kasutaja_tk_str_id") {
                        if (authenticationDidFail == true){
                            authenticationDidFail = false
                        }
                        authenticationDidSucceed = true
                    }
                    else {
                        if (authenticationDidSucceed == true){
                            authenticationDidSucceed = false
                        }
                        authenticationDidFail = true
                    }
                }
            }
            //print(loginHTMLString)
        } catch let error {
            print("Error: \(error)")
        }
    }
    func showTunnip(){
        /*let loginURLString = "https://ois2.tlu.ee/tluois/!uus_ois2.ois_public.page?_page=9A46066693F9020547B19035E345EAEE&p_type=ois&p_user=\(username)&p_pwd=\(password)&p_mobiil=big&p_mobiil_tel="
        
        let session = URLSession.shared
        
        guard let loginURL = URL(string: loginURLString) else { return }
        */
        tryLogin()
        let tunnipURLString = "https://ois2.tlu.ee/tluois/!uus_ois2.ois_public.page?_page=21D02BFC64FA0CCC52A388D2A2990C7D90419DA7F185EAC00AA85210028D3067&d=1&p_sess=x&p_rnd=1615160982141"
        guard let tunnipURL = URL(string: tunnipURLString) else { return }
        do {
            let tunnipHTMLString = try! String(contentsOf: tunnipURL, encoding: .utf8)
            //let loginHTMLContent = loginHTMLString
            do {
                let docTunnip: Document = try SwiftSoup.parseBodyFragment(tunnipHTMLString)
                do {
                    let tunnidElem = try! docTunnip.getElementsByClass("large_link2")
                    //var tunnid: [String] = []
                    let ryhmadElem = try! docTunnip.getElementsByTag("span")
                    var ryhmad: [String] = []
                    let klassElem = try docTunnip.select("div > div > div + div + div + div")
                    var klass: [String] = []
                    let aineKoodaineOppejoudElem = try docTunnip.select("div > div > div")
                    var oppejoud: [String] = []
                    var ainekood: [String] = []
                    var kellAine: [String] = []

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
                    
                    print (tunnid)
                    print (ryhmad)
                    print (klass)
                    print (ainekood)
                    print (oppejoud)
                    print (kellAine)
                    
                    return tunnid, ryhmad, klass, ainekood, oppejoud, kellAine
                }
        } catch let error {
            print("Error: \(error)")
        }
    }
}
}
