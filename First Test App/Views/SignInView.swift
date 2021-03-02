//
//  SignInView.swift
//  First Test App
//
//  Created by Cristian Torres on 2/28/21.
//

import SwiftUI

struct SignInView: View {
    
    let features: [String] = ["Sync across devices?", "Share list with Friends?", "Create Group Project Tasks"]
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(alignment: .center) {
            Text("Welcome to Tasky!")
                .bold()
                .font(/*@START_MENU_TOKEN@*/.largeTitle/*@END_MENU_TOKEN@*/)
                
            Spacer()
                .frame(height: 30)
            Text("Do you want to....")
                .bold()
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            Spacer()
                .frame(height: 30)
            
            List {
                ForEach(features, id: \.self) { feature in
                    HStack {
                        Spacer()
                            .frame(width: 75)
                        Image(systemName: "checkmark")
                        Spacer()
                            .frame(width: 25)
                        Text(feature)
                        Spacer()
                    }
                }
            }
            .frame(height: 130)
            
            Spacer()
                .frame(height: 120)
            
            Text("Create an Account Today!")
                .bold()
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            
            SignInWithAppleButton()
                .frame(width: 280, height: 45)
                .onTapGesture {
                    //TODO: Sign In User
                    self.presentationMode.wrappedValue.dismiss()
                }
            
            Spacer()
                .frame(height: 300)
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
