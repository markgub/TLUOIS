//
//  ExperimentFunc.swift
//  OIS
//
//  Created by User on 25.04.2021.
//

import Foundation
import SwiftUI
import SwiftSoup
import WebKit

struct ExperimentFunc {
    
    func testFunc(){
        let myURLString = "https://ois2.tlu.ee/tluois/!uus_ois2.ois_public.page?_page=413332E484BE8E405928509CC8823271CB8D8439E6FAACB6796840DCFFC61206"
        guard let myURL = URL(string: myURLString) else {return}
        
        do {
            let contents = try String(contentsOf: myURL)
            do {
                let docMain: Document = try SwiftSoup.parseBodyFragment(contents)
                
                let headers: Elements = try docMain.getElementsByClass("card-header")
                let esivorm21: Elements = try docMain.select("[id=esivorm21]").select("div:not([class])")
                //let esivorm21Main: Elements = try esivorm21
                
                var headersString: [String] = []
                var esivorm21EAP: [String] = []
                var i = 0, j = 0
                //let grades: Elements = esivorm2!.children()
                
                /*for element in headers{
                    headersString.append(try! element.text())
                    print(headersString[i])
                    i += 1
                }*/
                
                for element in esivorm21{
                    if(i%3 == 0){
                        esivorm21EAP.append(try! element.text())
                        print(esivorm21EAP[j])
                        j += 1
                    }
                    i += 1
                }
                print(try! esivorm21.text())
            }catch let error {
                print("Error: \(error)")
            }
        } catch let error {
            print("Error: \(error)")
        }
    }
    
    //guard let myURL = myURLString(string: myURLString) else { return }
    
    
}
