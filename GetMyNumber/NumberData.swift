//
//  NumberData.swift
//  GetMyNumber
//
//  Created by Center for Innovation on 1/7/20.
//  Copyright © 2020 dinaolmelak. All rights reserved.
//

import Foundation

class NumberData {
    var group: Int!
    var order: Int!
    
    func NumberData(Group inGroup:Int, Order inOrder: Int){
        group = inGroup
        order = inOrder
    }
    
    func getGroupNum() -> Int{
        return group
    }
    func getOrderNum() -> Int{
        return order
    }
}
