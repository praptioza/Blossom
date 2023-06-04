//
//  Validation.swift
//  Blossom

import Foundation

// Email Validation Function
extension String{
   
    func isValidEmail() -> Bool {
        let emailRegEx = try! NSRegularExpression(pattern: "^[\\p{L}0-9!#$%&'*+\\/=?^_`{|}~-][\\p{L}0-9.!#$%&'*+\\/=?^_`{|}~-]{0,63}@[\\p{L}0-9-]+(?:\\.[\\p{L}0-9-]{2,7})*$"
   , options: .caseInsensitive)
        
        return emailRegEx.firstMatch(in: self, range: NSRange(location: 0, length: count)) != nil
    }
    
}
