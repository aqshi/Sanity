//
//  Budget.swift
//  Sanity
//
//  Created by Max Wong on 10/13/2017.
//  Copyright © 2017 Leftover System. All rights reserved.
//

import UIKit

struct Budget{
    
    init(      name: String,
               intervalStartDate: String,     //Initial day to begin interval
               intervalResetOn: Int,  //Day we need to reset (P2)
               alwaysResetOn: String, //Always Reset on This date (P1)
               resetInterval: String, //How often to reset
               budgetAmount: Double,
               budgetUsed: Double,
               notificationPercent: Double,
               notificationFrequency: String,
               categoryList: [String : Category]) {
        
        //self.budgetID = budgetID
        self.name = name
        
        self.budgetAmount = budgetAmount
        self.budgetUsed = budgetUsed
        self.notificationPercent = notificationPercent
        self.notificationFrequency = notificationFrequency
        self.categoryList = categoryList
        
        
        self.alwaysResetOn = alwaysResetOn     //Always Reset on This date (P1)
        self.intervalResetOn = intervalResetOn //Day we need to reset (P2)
        self.intervalStartDate = intervalStartDate //Initial day to begin interval
        self.resetInterval = resetInterval //How often to reset
        
        
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        
        //process the interval
        calcInterval()
        
        update()
        
        
        //stored here
        self.recentIntervalResetString = formatter.string(from: recentIntervalReset)
        self.nextIntervalResetString = formatter.string(from: nextIntervalReset)
        self.nextFixedResetString = formatter.string(from: nextFixedReset)
        
        //when to really reset
        self.nextDateResetString = formatter.string(from: nextDateReset)
        
        
        
    }
    
    init(name: String,
        intervalStartDate: String,     //Initial day to begin interval
        intervalResetOn: Int,  //Day we need to reset (P2)
        alwaysResetOn: String, //Always Reset on This date (P1)
        resetInterval: String, //How often to reset
        budgetAmount: Double,
        budgetUsed: Double,
        notificationPercent: Double,
        notificationFrequency: String,
        recentIntervalReset: String,
        nextIntervalReset: String,
        nextFixedReset: String,
        nextDateReset: String,
        categoryList: [String : Category])  {
        self.name = name
        self.budgetAmount = budgetAmount
        self.budgetUsed = budgetUsed
        self.notificationPercent = notificationPercent
        self.notificationFrequency = notificationFrequency
        self.categoryList = categoryList
        
        
        self.alwaysResetOn = alwaysResetOn     //Always Reset on This date (P1)
        self.intervalResetOn = intervalResetOn //Day we need to reset (P2)
        self.intervalStartDate = intervalStartDate //Initial day to begin interval
        self.resetInterval = resetInterval //How often to reset
        
        self.recentIntervalResetString = recentIntervalReset
        self.nextIntervalResetString = nextIntervalReset
        self.nextFixedResetString = nextFixedReset
        self.nextDateResetString = nextDateReset
        print(self.recentIntervalResetString)
        print(self.nextIntervalResetString)
        print(self.nextDateResetString)
        print(self.nextFixedResetString)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        self.recentIntervalReset = dateFormatter.date(from:self.recentIntervalResetString)!
        self.nextIntervalReset = dateFormatter.date(from:self.nextIntervalResetString)!
        self.nextDateReset = dateFormatter.date(from:self.nextDateResetString)!
        self.nextFixedReset = dateFormatter.date(from:self.nextFixedResetString)!
    }
    
    
    //var budgetID: String
    var name: String
    
    var alwaysResetOn: String //Always Reset on This date (P1)
    var intervalResetOn: Int //Day we need to reset (P2)
    var intervalStartDate: String //Initial day to begin interval
    var resetInterval: String //How often to reset
    
    
    
    
    var budgetAmount: Double
    var budgetUsed: Double
    var notificationPercent: Double
    var notificationFrequency: String
    var categoryList = [String : Category]()
    
    //my dates
    var recentIntervalReset = Date()
    var nextIntervalReset = Date()
    var nextDateReset = Date()
    var nextFixedReset = Date()
    
    //my dates in strings
    var recentIntervalResetString : String = ""
    var nextIntervalResetString : String = ""
    var nextDateResetString : String = ""
    var nextFixedResetString : String = ""
    
    
    
    mutating func calcTotal() -> Double {
        self.budgetAmount = 0
        for(_ , Category) in categoryList{
            budgetAmount = budgetAmount + Category.amountLimit
        }
        return budgetAmount
    }
    
    mutating func calcUsed() -> Double {
        self.budgetUsed = 0
        for(_ , Category) in categoryList{
            budgetUsed = budgetUsed + Category.amountUsed
        }
        return budgetUsed
    }
    
    
    
    
    
    
    
    
    
    mutating func update () -> Double {
        calcUsed()
        calcTotal()
        calculateNearestDate()
        //recoverDateObjects()
        let currentDate = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        let currentDateString = formatter.string(from: currentDate)
        if(self.nextDateResetString == currentDateString){
        calculateReset()
            return 1
        }
        return 0
    }
    
    mutating func recoverDateObjects() -> Int {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy" //Your date format
        self.nextIntervalReset = dateFormatter.date(from: self.nextIntervalResetString)!
        
        self.recentIntervalReset = dateFormatter.date(from: self.recentIntervalResetString)!
        
        self.nextFixedReset = dateFormatter.date(from: self.nextFixedResetString)!
        
        self.nextDateReset = dateFormatter.date(from: self.nextDateResetString)!
        return 0
    }
    
    mutating func calculateReset(){
        
        //get the current date
        let currentDate = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        let currentDateString = formatter.string(from: currentDate)
        
        //if the next date reset = Today!?
        if(self.nextDateResetString == currentDateString){
            //delete all of my purchases
            for( String , _ ) in self.categoryList {
                self.categoryList[String]!.clearPurchases()
                self.categoryList[String]!.calcUsed()
            }
        }
        
        //update my values
        calcUsed()
        calcTotal()
        
        //I deleted all of my Purchases. Now I have to move intervalReset forward
        if(self.resetInterval == "0"){
            var dateComponent = DateComponents()
            dateComponent.day = 7
            let futureDate = Calendar.current.date(byAdding: dateComponent, to: self.nextIntervalReset)
            self.nextIntervalReset = futureDate!
        }
        else if (self.resetInterval == "1"){
            var dateComponent = DateComponents()
            dateComponent.day = 14
            let futureDate = Calendar.current.date(byAdding: dateComponent, to: self.nextIntervalReset)
            self.nextIntervalReset = futureDate!
        }
        else if (self.resetInterval == "2"){
            var dateComponent = DateComponents()
            dateComponent.day = 21
            let futureDate = Calendar.current.date(byAdding: dateComponent, to: self.nextIntervalReset)
            self.nextIntervalReset = futureDate!
        }
        else if (self.resetInterval == "3"){
            var dateComponent = DateComponents()
            dateComponent.day = 28
            let futureDate = Calendar.current.date(byAdding: dateComponent, to: self.nextIntervalReset)
            self.nextIntervalReset = futureDate!
        }
        
        //move FDR forward one month
        var dateComponent = DateComponents()
        dateComponent.month = 1
        let futureDate = Calendar.current.date(byAdding: dateComponent, to: self.nextFixedReset)
        self.nextFixedReset = futureDate!
        
        
        if (self.nextFixedReset < self.nextIntervalReset){
            self.nextDateReset = self.nextFixedReset
        }
        else {
            self.nextDateReset = self.nextIntervalReset
        }
        
        //format it because we have to display it
        self.nextDateResetString = formatter.string(from: self.nextDateReset)
        print(nextDateResetString)
        //stored here
        self.recentIntervalResetString = formatter.string(from: recentIntervalReset)
        self.nextIntervalResetString = formatter.string(from: nextIntervalReset)
        self.nextFixedResetString = formatter.string(from: nextFixedReset)
        
        
    }
    
    
    
    
    
    mutating func calculateNearestDate() -> String{
        
        //Establish the current date
        let currentDate = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        let currentDateString = formatter.string(from: currentDate)
        //print(currentDateString)
        
        
        //get the AlwaysResetOnDate
        var actingARD = ""
        //check if february
        if(currentDateString.contains("Feb")){
            if(Int(alwaysResetOn)! > 28){
                actingARD = "28"
            }
        }
        //check if we are a 30 day month
        else if(currentDateString.contains("Sep")){
            if(Int(alwaysResetOn)! > 30){
                actingARD = "30"
            }
        }
        else if(currentDateString.contains("Apr")){
            if(Int(alwaysResetOn)! > 30){
                actingARD = "30"
            }
        }
        else if(currentDateString.contains("Jun")){
            if(Int(alwaysResetOn)! > 30){
                actingARD = "30"
            }
        }
        else if(currentDateString.contains("Nov")){
            if(Int(alwaysResetOn)! > 30){
                actingARD = "30"
            }
        }
        else {
            actingARD = alwaysResetOn
        }
        let gregorian = Calendar(identifier: .gregorian)
        let now = Date()
        var components = gregorian.dateComponents([.year, .month, .day], from: now)
        
        print(actingARD + " ACTINGARD")
        if( actingARD != "0"){
            components.day = Int(actingARD)!
            self.nextFixedReset = gregorian.date(from: components)!
            //if we past the date, push us forward!
            if(self.nextFixedReset < now){
                var dateComponent = DateComponents()
                dateComponent.month = 1
                let futureDate = Calendar.current.date(byAdding: dateComponent, to: self.nextFixedReset)
                self.nextFixedReset = futureDate!
            }
            let ARDString = formatter.string(from: self.nextFixedReset)
            print(ARDString + " next fixed reset")
        }
            
        else{
            let formatter = DateFormatter()
            formatter.dateFormat = "dd MMM yyyy"
            let someDateTime = formatter.date(from: "01 Jan 9999")
            self.nextFixedReset = someDateTime!
            
            let ARDString = formatter.string(from: self.nextFixedReset)
            print(ARDString + " next fixed reset")
        }
        
        
        
        
        //get the Interval date (what a bitch)
        // first get next _____
        let nextIntReset = self.nextIntervalReset
        let nextIntString = formatter.string(from: nextIntReset)
        print(nextIntString + " next Interval reset")
        
        
        //Determine the nearest one!
        if (self.nextFixedReset < self.nextIntervalReset){
            self.nextDateReset = self.nextFixedReset
        }
        else {
            self.nextDateReset = self.nextIntervalReset
        }
        
        //format it because we have to display it
        self.nextDateResetString = formatter.string(from: self.nextDateReset)
        print(nextDateResetString)
        //stored here
        self.recentIntervalResetString = formatter.string(from: recentIntervalReset)
        self.nextIntervalResetString = formatter.string(from: nextIntervalReset)
        self.nextFixedResetString = formatter.string(from: nextFixedReset)
        
        
        return ""
    }
    
    
    mutating func calcInterval() -> Double {
        
        
        
        
        
        //if they selected "Don't", then we never use the interval start date
        if(self.intervalStartDate == "0"){
           self.intervalStartDate = ""
            
            let formatter = DateFormatter()
            formatter.dateFormat = "dd MMM yyyy"
            let someDateTime = formatter.date(from: "01 Jan 9999")
            self.nextIntervalReset = someDateTime!
            self.recentIntervalReset = someDateTime!
            
            return 0
        }
        
        let daysOfWeek = ["z","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday"]

        if(resetInterval == "0"){
            if(self.intervalStartDate == "" && Dummy.intervalStartDate[self.name] != nil){
                self.intervalStartDate = Dummy.intervalStartDate[self.name]!
            }
            Dummy.intervalStartDate[self.name] = self.intervalStartDate
            if(self.intervalStartDate != ""){
                self.nextIntervalReset = get(direction: .Next, daysOfWeek[Int(self.intervalStartDate)!]) as Date
                self.recentIntervalReset = get(direction: .Previous, daysOfWeek[Int(self.intervalStartDate)!]) as Date
                self.intervalStartDate = ""
            } else {
                self.intervalStartDate = ""
                let formatter = DateFormatter()
                formatter.dateFormat = "dd MMM yyyy"
                let someDateTime = formatter.date(from: "01 Jan 9999")
                self.nextIntervalReset = someDateTime!
                self.recentIntervalReset = someDateTime!
            }
        }
        else if(resetInterval == "1"){
            if(self.intervalStartDate == "" && Dummy.intervalStartDate[self.name] != nil){
                self.intervalStartDate = Dummy.intervalStartDate[self.name]!
            }
            Dummy.intervalStartDate[self.name] = self.intervalStartDate
            if(self.intervalStartDate != ""){
                self.nextIntervalReset = get(direction: .Next, daysOfWeek[Int(self.intervalStartDate)!]) as Date
                self.recentIntervalReset = get2previous(direction: .Previous, daysOfWeek[Int(self.intervalStartDate)!]) as Date
                self.intervalStartDate = ""
            } else {
                self.intervalStartDate = ""
                let formatter = DateFormatter()
                formatter.dateFormat = "dd MMM yyyy"
                let someDateTime = formatter.date(from: "01 Jan 9999")
                self.nextIntervalReset = someDateTime!
                self.recentIntervalReset = someDateTime!
            }
        }
        else if(resetInterval == "2"){
            if(self.intervalStartDate == "" && Dummy.intervalStartDate[self.name] != nil){
                self.intervalStartDate = Dummy.intervalStartDate[self.name]!
            }
            Dummy.intervalStartDate[self.name] = self.intervalStartDate
            if(self.intervalStartDate != ""){
                self.nextIntervalReset = get(direction: .Next, daysOfWeek[Int(self.intervalStartDate)!]) as Date
                self.recentIntervalReset = get3previous(direction: .Previous, daysOfWeek[Int(self.intervalStartDate)!]) as Date
                self.intervalStartDate = ""
            } else {
                self.intervalStartDate = ""
                let formatter = DateFormatter()
                formatter.dateFormat = "dd MMM yyyy"
                let someDateTime = formatter.date(from: "01 Jan 9999")
                self.nextIntervalReset = someDateTime!
                self.recentIntervalReset = someDateTime!
            }
        }
        else if(resetInterval == "3"){
            if(self.intervalStartDate == "" && Dummy.intervalStartDate[self.name] != nil){
                self.intervalStartDate = Dummy.intervalStartDate[self.name]!
            }
            Dummy.intervalStartDate[self.name] = self.intervalStartDate
            if(self.intervalStartDate != ""){
                self.nextIntervalReset = get(direction: .Next, daysOfWeek[Int(self.intervalStartDate)!]) as Date
                self.recentIntervalReset = get4previous(direction: .Previous, daysOfWeek[Int(self.intervalStartDate)!]) as Date
                self.intervalStartDate = ""
            } else {
                self.intervalStartDate = ""
                let formatter = DateFormatter()
                formatter.dateFormat = "dd MMM yyyy"
                let someDateTime = formatter.date(from: "01 Jan 9999")
                self.nextIntervalReset = someDateTime!
                self.recentIntervalReset = someDateTime!
            }
        }
        
        return 0
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    //never go there simba
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    //LOL PRAISE GOOGLE
    func getWeekDaysInEnglish() -> [String] {
        let calendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
        calendar.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale
        return calendar.weekdaySymbols
    }
    
    enum SearchDirection {
        case Next
        case Previous
        
        var calendarOptions: NSCalendar.Options {
            switch self {
            case .Next:
                return .matchNextTime
            case .Previous:
                return [.searchBackwards, .matchNextTime]
            }
        }
    }
    
    func get(direction: SearchDirection, _ dayName: String, considerToday consider: Bool = false) -> NSDate {
        let weekdaysName = getWeekDaysInEnglish()
        
        assert(weekdaysName.contains(dayName), "weekday symbol should be in form \(weekdaysName)")
        
        let nextWeekDayIndex = weekdaysName.index(of: dayName)! + 1 // weekday is in form 1 ... 7 where as index is 0 ... 6
        
        let today = NSDate()
        
        let calendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
        
        if consider && calendar.component(.weekday, from: today as Date) == nextWeekDayIndex {
            return today
        }
        
        let nextDateComponent = NSDateComponents()
        nextDateComponent.weekday = nextWeekDayIndex
        
        
        let date = calendar.nextDate(after: today as Date, matching: nextDateComponent as DateComponents, options: direction.calendarOptions)
        return date! as NSDate
    }
    
    func get2previous(direction: SearchDirection, _ dayName: String, considerToday consider: Bool = false) -> NSDate {
        let weekdaysName = getWeekDaysInEnglish()
        
        assert(weekdaysName.contains(dayName), "weekday symbol should be in form \(weekdaysName)")
        
        let nextWeekDayIndex = weekdaysName.index(of: dayName)! + 1 // weekday is in form 1 ... 7 where as index is 0 ... 6
        
        let today = get(direction: .Previous , dayName)
        
        let calendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
        
        if consider && calendar.component(.weekday, from: today as Date) == nextWeekDayIndex {
            return today
        }
        
        let nextDateComponent = NSDateComponents()
        nextDateComponent.weekday = nextWeekDayIndex
        
        
        let date = calendar.nextDate(after: today as Date, matching: nextDateComponent as DateComponents, options: direction.calendarOptions)
        return date! as NSDate
    }
    
    func get2next(direction: SearchDirection, _ dayName: String, considerToday consider: Bool = false) -> NSDate {
        let weekdaysName = getWeekDaysInEnglish()
        
        assert(weekdaysName.contains(dayName), "weekday symbol should be in form \(weekdaysName)")
        
        let nextWeekDayIndex = weekdaysName.index(of: dayName)! + 1 // weekday is in form 1 ... 7 where as index is 0 ... 6
        
        let today = get(direction: .Next , dayName)
        
        let calendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
        
        if consider && calendar.component(.weekday, from: today as Date) == nextWeekDayIndex {
            return today
        }
        
        let nextDateComponent = NSDateComponents()
        nextDateComponent.weekday = nextWeekDayIndex
        
        
        let date = calendar.nextDate(after: today as Date, matching: nextDateComponent as DateComponents, options: direction.calendarOptions)
        return date! as NSDate
    }
    
    func get3previous(direction: SearchDirection, _ dayName: String, considerToday consider: Bool = false) -> NSDate {
        let weekdaysName = getWeekDaysInEnglish()
        
        assert(weekdaysName.contains(dayName), "weekday symbol should be in form \(weekdaysName)")
        
        let nextWeekDayIndex = weekdaysName.index(of: dayName)! + 1 // weekday is in form 1 ... 7 where as index is 0 ... 6
        
        let today = get2previous(direction: .Previous , dayName)
        
        let calendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
        
        if consider && calendar.component(.weekday, from: today as Date) == nextWeekDayIndex {
            return today
        }
        
        let nextDateComponent = NSDateComponents()
        nextDateComponent.weekday = nextWeekDayIndex
        
        
        let date = calendar.nextDate(after: today as Date, matching: nextDateComponent as DateComponents, options: direction.calendarOptions)
        return date! as NSDate
    }
    
    func get3next(direction: SearchDirection, _ dayName: String, considerToday consider: Bool = false) -> NSDate {
        let weekdaysName = getWeekDaysInEnglish()
        
        assert(weekdaysName.contains(dayName), "weekday symbol should be in form \(weekdaysName)")
        
        let nextWeekDayIndex = weekdaysName.index(of: dayName)! + 1 // weekday is in form 1 ... 7 where as index is 0 ... 6
        
        let today = get2previous(direction: .Next , dayName)
        
        let calendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
        
        if consider && calendar.component(.weekday, from: today as Date) == nextWeekDayIndex {
            return today
        }
        
        let nextDateComponent = NSDateComponents()
        nextDateComponent.weekday = nextWeekDayIndex
        
        
        let date = calendar.nextDate(after: today as Date, matching: nextDateComponent as DateComponents, options: direction.calendarOptions)
        return date! as NSDate
    }
    
    func get4previous(direction: SearchDirection, _ dayName: String, considerToday consider: Bool = false) -> NSDate {
        let weekdaysName = getWeekDaysInEnglish()
        
        assert(weekdaysName.contains(dayName), "weekday symbol should be in form \(weekdaysName)")
        
        let nextWeekDayIndex = weekdaysName.index(of: dayName)! + 1 // weekday is in form 1 ... 7 where as index is 0 ... 6
        
        let today = get3previous(direction: .Previous , dayName)
        
        let calendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
        
        if consider && calendar.component(.weekday, from: today as Date) == nextWeekDayIndex {
            return today
        }
        
        let nextDateComponent = NSDateComponents()
        nextDateComponent.weekday = nextWeekDayIndex
        
        
        let date = calendar.nextDate(after: today as Date, matching: nextDateComponent as DateComponents, options: direction.calendarOptions)
        return date! as NSDate
    }
    
    func get4next(direction: SearchDirection, _ dayName: String, considerToday consider: Bool = false) -> NSDate {
        let weekdaysName = getWeekDaysInEnglish()
        
        assert(weekdaysName.contains(dayName), "weekday symbol should be in form \(weekdaysName)")
        
        let nextWeekDayIndex = weekdaysName.index(of: dayName)! + 1 // weekday is in form 1 ... 7 where as index is 0 ... 6
        
        let today = get3previous(direction: .Next , dayName)
        
        let calendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
        
        if consider && calendar.component(.weekday, from: today as Date) == nextWeekDayIndex {
            return today
        }
        
        let nextDateComponent = NSDateComponents()
        nextDateComponent.weekday = nextWeekDayIndex
        
        
        let date = calendar.nextDate(after: today as Date, matching: nextDateComponent as DateComponents, options: direction.calendarOptions)
        return date! as NSDate
    }
    
    //get(.Next, "Monday") // Nov 2, 2015, 12:00 AM
    //get(.Next, "Sunday") // Nov 1, 2015, 12:00 AM
    
    //get(.Previous, "Sunday") // Oct 25, 2015, 12:00 AM
    //get(.Previous, "Monday") // Oct 26, 2015, 12:00 AM
    
    //get(.Previous, "Thursday") // Oct 22, 2015, 12:00 AM
    //get(.Next, "Thursday") // Nov 5, 2015, 12:00 AM
    //get(.Previous, "Thursday", considerToday:  true) // // Oct 29, 2015, 12:00 AM
    
}
