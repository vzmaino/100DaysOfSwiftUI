//
//  ContentView.swift
//  BucketList
//
//  Created by Vinicius Maino on 30/03/21.
//

import SwiftUI
import MapKit
import LocalAuthentication

struct ContentView: View {
    
    @State private var isUnlocked = false
    //challenge 3 (alert)
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showErrorAlert = false
    
    var body: some View {
        Group {
            if isUnlocked {
                MapContentView()
            } else {
                Button("Unlock Places") {
                    self.authenticate()
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .clipShape(Capsule())
                .alert(isPresented: $showErrorAlert) {
                    Alert(title: Text(errorTitle), message: Text(errorMessage), dismissButton: .default(Text("OK")))
                }
            }
        }
    }
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?

        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Please authenticate yourself to unlock your places."

            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in

                DispatchQueue.main.async {
                    if success {
                        self.isUnlocked = true
                    } else {
                        self.errorTitle = "Couldn't unlock"
                        self.errorMessage = "Your face wasn't recognized."
                        self.showErrorAlert = true
                    }
                }
            }
        } else {
            self.errorTitle = "Can't unlock!"
            self.errorMessage = "Your device doesn't support authentication with biometrics."
            self.showErrorAlert = true
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
