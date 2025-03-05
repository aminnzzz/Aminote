//
//  DataController-Awards.swift
//  Aminote
//
//  Created by amin nazemzadeh on 3/4/25.
//

import Foundation

extension DataController {
    func hasEarned(award: Award) -> Bool {
        switch award.criterion {
        case "issues":
            let request = Issue.fetchRequest()
            let awardCount = count(for: request)
            return awardCount >= award.value

        case "closed":
            let request = Issue.fetchRequest()
            request.predicate = NSPredicate(format: "completed = true")
            let awardCount = count(for: request)
            return awardCount >= award.value

        case "tags":
            let request = Tag.fetchRequest()
            let awardCount = count(for: request)
            return awardCount >= award.value

        case "unlock":
            return fullVersionUnlocked

        default:
//            fatalError("Unknown award criterion: \(award.criterion)")
            return false

        }
    }

}
