//
//  FirebaseDataManager.swift
//  Textbook
//
//  Created by Christina Lin on 9/7/19.
//  Copyright © 2019 Christina Lin. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

struct FirebaseDatabaseManager {
    private static let userRef = Database.database().reference(withPath: "users")
    private static var ref: DatabaseReference! = Database.database().reference()

    static func writeToUser(for u: User) {
        let auth = Auth.auth().currentUser;
        ref.child("users").child(auth!.uid).setValue([
            "firstName": u.firstName,
            "lastName": u.lastName,
            "email": u.email,
            "password": u.password,
            "venmo": u.venmo])
    }
}
