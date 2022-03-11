//
//  main.swift
//  HundredJoon
//
//  Created by 이진희 on 2022/03/10.
//
/*
import Foundation
import Swift
let num: String = readLine()!
let repeatNum: Int = Int(num)!

for _ in 1...repeatNum {
    let arr = readLine()!.split(separator: " ")
    let xInt : Int = Int(arr[0])! - Int(arr[3])!
    let yInt : Int = Int(arr[1])! - Int(arr[4])!
    
    
    let xy = pow(Decimal(xInt), 2) + pow(Decimal(yInt), 2)
    // print(xy)
    let rr = Int(arr[2])! + Int(arr[5])!
    let rrr = pow(Decimal(rr), 2)
    let rrrr=pow(Decimal(Int(arr[2])! - Int(arr[5])!), 2)
    if !( xInt == 0 && yInt == 0){
        if xy > rrr {
            print("0")
        }
        else if xy == rrr || xy == rrrr {
            print("1")
        }
        else if xy < rrr{
            print("2")
        }
    }
    else if (xInt == 0 && yInt == 0 ){
        if(arr[2] == arr[5]) {
            print("-1")
        }
        else {
            print("0")
        }
        
    }
}
*/


let T = Int(readLine()!)!
for _ in 1...T {
    let arr = readLine()!.split(separator: " ").map{ Int($0)! }
    var r1 = arr[2]
    var r2 = arr[5]
    let r = ((arr[0] - arr[3]) * (arr[0] - arr[3])) + ((arr[1] - arr[4]) * (arr[1] - arr[4]))
    
    if r2 > r1 {
        let temp = r1
        r1 = r2
        r2 = temp
    }
    
    
    if r1 == r2 && r == 0 {
        print("-1")
    }else if (r1 - r2) * (r1 - r2) > r || (r1 + r2) * (r1 + r2) < r  {
        print("0")
    }else if (r1 + r2) * (r1 + r2) == r || r  == (r1 - r2) * (r1 - r2) {
        print("1")
    }else {
        print("2")
    }
}
