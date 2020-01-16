//
//  NumberData.swift
//  GetMyNumber
//
//  Created by Center for Innovation on 1/7/20.
//  Copyright © 2020 dinaolmelak. All rights reserved.
//

import Foundation

class NumberData {
    var guess: Int!
    var group: Int?
    var order: Int?
    var isChecked: Bool!
    
    func NumberData(Guess inGuess: Int, Group inGroup:Int, Order inOrder: Int,Checked inChecked: Bool){
        guess = inGuess
        group = inGroup
        order = inOrder
        isChecked = inChecked
    }
    func setResults(Group inGroup:Int, Order inOrder: Int){
        group = inGroup
        order = inOrder
    }
    func setGuess(Guess inGuess: Int){
        guess = inGuess
    }
    func getGuess()->Int{
        return guess
    }
    func getCheckStatus()->Bool{
        return isChecked
    }
    func setChecked(){
        isChecked = true
    }
    func setNotChecked(){
        isChecked = false
    }
    
    func getGroupNum() -> Int?{
        return group
    }
    func getOrderNum() -> Int?{
        return order
    }
}
