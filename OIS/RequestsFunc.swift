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
    
    //Variables that we receive from LoginPageView. They contain username and password of user
    @Binding var username: String
    @Binding var password: String
    
    //Variables from LoginPageView that control if we succeded in our log in attempt
    @Binding var authenticationDidFail: Bool
    @Binding var authenticationDidSucceed: Bool
    
    //Function that we use to log in to ÕIS
    func tryLogin() {
        //URL that we parse username and password into
        let loginURLString = "https://ois2.tlu.ee/tluois/!uus_ois2.ois_public.page?_page=9A46066693F9020547B19035E345EAEE&p_type=ois&p_user=\(username)&p_pwd=\(password)&p_mobiil=big&p_mobiil_tel="
        guard let loginURL = URL(string: loginURLString) else { return }
            
        do {
            let loginHTMLString = try! String(contentsOf: loginURL, encoding: .utf8)
            do {
                //Contents of page
                let doc: Document = try SwiftSoup.parse(loginHTMLString)
                do {
                    let loginHTMLParsed = try doc.select("input").first()!
                    
                    let authSuccText = try! loginHTMLParsed.attr("name")
                    
                    //If we get this piece of text then we succeded
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
        } catch let error {
            //Prints out the error if one occures
            print("Error: \(error)")
        }
    }
}
