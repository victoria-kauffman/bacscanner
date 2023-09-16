//
//  bacCalc.swift
//  bacscanner
//
//  Created by Victoria Kauffman on 9/16/23.
//

import Foundation

let statements = ["Not even drunk", "How are you not dead?"]

func readBac(bac: Float) -> Int {
    switch bac {
    case 0..<0.02:
        return 0
    case 0.02..<0.04:
        return 1
    case 0.04..<0.06:
        return 2
    case 0.06..<0.1:
        return 3
    case 0.1..<0.13:
        return 4
    case 0.13..<0.16:
        return 5
    case 0.16..<0.2:
        return 6
    case 0.2..<0.25:
        return 7
    case 0.25..<0.4:
        return 8
    default:
        return 9
    }
}
