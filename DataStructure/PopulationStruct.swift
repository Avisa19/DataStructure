//
//  PopulationStruct.swift
//  DataStructure
//
//  Created by Avisa on 24/4/19.
//  Copyright © 2019 Avisa Poshtkouhi. All rights reserved.
//

import Foundation
import UIKit


struct Person {
    var birthDate: Int
    var diedDate: Int? = nil
}

struct Population {
    var persons = [Person]()
    var statistics = [Int: Int]()
    
    init(people: [Person]) {
        self.persons = people
    }
    
    mutating func getPopulationStatistics() -> [Int] {
        for per in persons {
            if let dead = per.diedDate {
                if let value = statistics[dead + 1] {
                    statistics[dead + 1] = value - 1
                } else {
                    statistics[dead + 1] = -1
                }
            }
            if let value = statistics[per.birthDate] {
                statistics[per.birthDate] = value + 1
            } else {
                statistics[per.birthDate] = 1
            }
        }
        
        let finalStatistics = statistics.sorted(by: { return $0.key < $1.key })
        var sum = 0
        
        var yearsLowerPopulation = [Int]()
        
        for i in 0 ..< finalStatistics.count {
            let newSum = sum + finalStatistics[i].value
            if newSum < sum {
                yearsLowerPopulation.append(finalStatistics[i].key)
            }
            sum = newSum
        }
        return yearsLowerPopulation
    }
}

func test() {
    let people = [
        Person(birthDate: 1902, diedDate: 1991),
        Person(birthDate: 1941, diedDate: 1978),
        Person(birthDate: 2004, diedDate: nil),
        Person(birthDate: 1957, diedDate: nil),
        Person(birthDate: 1989, diedDate: 2008),
        Person(birthDate: 1909, diedDate: 2005),
        Person(birthDate: 1918, diedDate: nil),
        Person(birthDate: 1913, diedDate: 2010),
        Person(birthDate: 1979, diedDate: nil),
        Person(birthDate: 1961, diedDate: 2002),
        Person(birthDate: 1977, diedDate: 2003),
        Person(birthDate: 1909, diedDate: 1991),
    ]
    var population = Population(people: people)
    print(population.getPopulationStatistics())
}


