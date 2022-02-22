//
//  TaskViewModel.swift
//  TaskManagement
//
//  Created by Muhammad Abbas on 14/01/2022.
//

import SwiftUI

class TaskViewModel: ObservableObject {
    @Published var storedTasks: [Task] = [
        Task(taskTitle: "Meeting", taskDescription: "Discuss task with team members", taskDate: .init(timeIntervalSince1970: 1642180090)),
        Task(taskTitle: "Zoom Meeting", taskDescription: "Its about Zoom meeting", taskDate: .init(timeIntervalSince1970: 1642179860)),
        Task(taskTitle: "Skype Meeting", taskDescription: "Its about Skype meeting", taskDate: .init(timeIntervalSince1970: 1642183460)),
        Task(taskTitle: "Prayer Time", taskDescription: "Its prayer time!!!!", taskDate: .init(timeIntervalSince1970: 1642183460)),
        Task(taskTitle: "Jummah Mubarak", taskDescription: "Its Jummah time !!!!!", taskDate: .init(timeIntervalSince1970: 1642077860))
    ]
    
    @Published var currentWeek: [Date] = []
    @Published var currentDay: Date = Date()
    @Published var filteredTasks: [Task]?
    
    init(){
        fetchCurrentWeek()
        filterTodayTasks()
    }
    
    func filterTodayTasks(){
        
        DispatchQueue.global(qos: .userInteractive).async {
            
            let calendar = Calendar.current
            
            let filtered = self.storedTasks.filter{
                return calendar.isDate($0.taskDate, inSameDayAs: self.currentDay)
            }
                .sorted { task1, task2 in
                    task1.taskDate > task2.taskDate
                }
            
            DispatchQueue.main.async {
                withAnimation {
                    self.filteredTasks = filtered
                }
            }
            
        }
        
    }
    
    func fetchCurrentWeek(){
        
        let today = Date()
        let calendar = Calendar.current
        
        let week = calendar.dateInterval(of: .weekOfMonth, for: today)
        
        guard let firstWeekDay = week?.start else{
            return
        }
        
        (1...7).forEach { day in
            
            if let weekDay = calendar.date(byAdding: .day, value: day, to: firstWeekDay){
                currentWeek.append(weekDay)
            }
            
        }
    }
    
    func extractDate(date: Date, formate: String) -> String{
        
        let formatter = DateFormatter()
        
        formatter.dateFormat = formate
        
        return formatter.string(from: date)
        
    }
    
    func isToday(date: Date) -> Bool{
        
        let calendar = Calendar.current
        
        return calendar.isDate(currentDay, inSameDayAs: date)
        
    }
    
    func isCurrentHour(date: Date) -> Bool{
        let calendar = Calendar.current
        
        let hour = calendar.component(.hour, from: date)
        let currentHour = calendar.component(.hour, from: Date())
        
        return hour == currentHour
    }
    
}

