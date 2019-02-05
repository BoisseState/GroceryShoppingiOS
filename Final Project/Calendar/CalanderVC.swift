//
//  ViewController.swift
//  Calendar
//
//  Created by Joe Boisse on 12/9/18.
//  Copyright © 2018 Joe Boisse. All rights reserved.
//

import UIKit
import JTAppleCalendar

class CalendarVC:  MainViewController {
    
    @IBOutlet weak var monthLabel : UILabel!
    @IBOutlet weak var yearLabel : UILabel!
    @IBOutlet weak var tabBar: UITabBar!
    @IBOutlet weak var calendarView: JTAppleCalendarView!
    
    var recipeDate : RecipeCD?
    var setSegue : Int = 0
    let formatter = DateFormatter()
    let model = RecipeModel()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        setupCalendarView()
        calendarView.scrollToDate(Date(), animateScroll:false)
        
        
    }
    func setupCalendarView(){
        calendarView.minimumLineSpacing = 0
        calendarView.minimumInteritemSpacing = 0
        
        calendarView.visibleDates { (visibleDates) in
            self.setupMonthandYear(from: visibleDates)
        }
    }
    
    func setupMonthandYear(from visibleDates: DateSegmentInfo){
        let date = visibleDates.monthDates.first!.date
        
        self.formatter.dateFormat = "yyyy"
        self.yearLabel.text = self.formatter.string(from: date)
        
        self.formatter.dateFormat = "MMMM"
        self.monthLabel.text = self.formatter.string(from: date)
    }
   
    func handleCellSelected(view: JTAppleCell?, cellState: CellState){
        guard let cell = view as? CustomCell else {return}
        if cellState.isSelected{
           cell.dateLabel.textColor = UIColor.selectedMonth
        }
        else{
            if cellState.dateBelongsTo == .thisMonth {
                 cell.dateLabel.textColor = UIColor.white
            }
            else{
                 cell.dateLabel.textColor = UIColor.outsideMonth
            }
        }
    }
    
    func handleCellTextColor(view: JTAppleCell?, cellState: CellState){
        guard let cell = view as? CustomCell else {return}
        if cellState.isSelected{
            cell.selectedView.isHidden = false
        }
        else{
            cell.selectedView.isHidden = true
        }
    }
}

extension CalendarVC: JTAppleCalendarViewDataSource{
    
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        formatter.dateFormat = "yyyy MM dd"
        formatter.timeZone = Calendar.current.timeZone
        formatter.locale = Calendar.current.locale
        
        let startDate = formatter.date(from: "2018 01 01")!
        let endDate = formatter.date(from: "2020 12 31")!
        
        let parameters = ConfigurationParameters(startDate: startDate, endDate: endDate)
                                                
        
        return parameters
    }
    
    func configure(recipe: RecipeCD, set:Int){
        recipeDate = recipe
        setSegue = 1
    }
    
    
}



extension CalendarVC: JTAppleCalendarViewDelegate {
    func calendar(_ calendar: JTAppleCalendarView, willDisplay cell: JTAppleCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "CustomCell", for: indexPath) as! CustomCell
        
        handleCellSelected(view: cell, cellState: cellState)
        handleCellTextColor(view: cell, cellState: cellState)
        
       
    }
    
    func calendar(_ calendar:JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "CustomCell", for: indexPath) as! CustomCell
        cell.dateLabel.text = cellState.text
        handleCellSelected(view: cell, cellState: cellState)
        handleCellTextColor(view: cell, cellState: cellState)
       // self.calendar(calendar, willDisplay: cell, forItemAt: date, cellState: cellState, indexPath: indexPath)
        return cell
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo){
        setupMonthandYear(from: visibleDates)
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState){
        handleCellSelected(view: cell, cellState: cellState)
        handleCellTextColor(view: cell, cellState: cellState)
        if(setSegue == 1){
            let dateStr = date.description.prefix(10)
            setSegue = 0;
            self.performSegue(withIdentifier: "goback", sender: self)
        }
       
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleCell?, cellState: CellState){
        handleCellSelected(view: cell, cellState: cellState)
        handleCellTextColor(view: cell, cellState: cellState)
    }
    
}
