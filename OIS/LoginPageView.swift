//
//  ContentView.swift
//  OIS
//
//
import SwiftUI
import SwiftSoup
import WebKit

let lightGreyColor = Color(red: 239.0/255.0, green: 243.00/255.0, blue: 244.0/255.0)

let darkRedColor = Color(red: 0.72, green: 0.07, blue: 0.20)

struct LoginPageView: View {
    
    //Variables that will hold username and password of user
    @State var username: String = UserDefaults.standard.string(forKey: "Username") ?? ""
    @State var password: String = ""
    
    //Booleans that will control the success of log in attempt
    @State var authenticationDidFail: Bool = false
    @State var authenticationDidSucceed: Bool = false
    
    //The final login page view that consists of ther views
    var body: some View {
        NavigationView {
            ZStack{
            VStack{
                Logo()
                HelloText()
                UsernameTextField(username: $username)
                PasswordSecureField(password: $password)
                
                if authenticationDidFail{
                    Text("Vale kasutajanimi või parool!")
                        .offset(y: -10)
                        .foregroundColor(darkRedColor)
                }
                //These navigation link in case of succesful login lead to the main page. Otherwise, it will inform user of failed log in attempt
                NavigationLink(destination: MainPageView(), isActive: $authenticationDidSucceed) {
                                    Button(action: {
                                        RequestsFunc(username: $username, password: $password, authenticationDidFail: $authenticationDidFail, authenticationDidSucceed: $authenticationDidSucceed).tryLogin()
                                        UserDefaults.standard.set(self.username, forKey: "Username")
                                    }) {
                                        LoginButtonContent()
                                    }
                }
                }
            }
            .padding()
            if authenticationDidSucceed{
                Text("Sisselogimine õnnestus!")
            }
        }
    }
}

struct HelloText: View {
    var body: some View {
        VStack{
            Text("Tere tulemast!")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .padding(.bottom, 20)
        }
    }
}
//The logo on the log in page
struct Logo: View {
    var body: some View {
        Image("TLU_logo")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 155, height: 30,alignment:/*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .clipped()
            .padding(.bottom, 10)
    }
}

struct UsernameTextField: View {
    
    @Binding var username: String
    
    var body: some View {
        TextField("KASUTAJANIMI", text: $username)
            .padding()
            .background(lightGreyColor)
            .cornerRadius(5.0)
            .padding(.bottom, 20)
            .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
            .disableAutocorrection(true)
    }
}

struct PasswordSecureField: View {
    
    @Binding var password: String
    
    var body: some View {
        SecureField("SALASÕNA", text: $password)
            .padding()
            .background(lightGreyColor)
            .cornerRadius(5.0)
            .padding(.bottom, 20)
    }
}

struct LoginButtonContent: View {
    var body: some View {
        Text("LOGI SISSE")
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(width: 220, height: 60)
            .background(darkRedColor)
            .cornerRadius(35.0)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginPageView()
    }
}



