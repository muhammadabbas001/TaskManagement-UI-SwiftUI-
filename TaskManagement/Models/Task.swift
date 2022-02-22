//
//  Task.swift
//  TaskManagement
//
//  Created by Muhammad Abbas on 14/01/2022.
//

import SwiftUI

struct Task: Identifiable{
    var id = UUID().uuidString
    var taskTitle: String
    var taskDescription: String
    var taskDate: Date
}
