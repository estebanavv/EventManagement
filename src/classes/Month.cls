public class Month {
    private List<Week> weeks;
    public Date firstDate; // always the first of the month
    private Date upperLeft;
    
    public List<Date> getValidDateRange() {
        // return one date from the upper left, and one from the lower right
        List<Date> ret = new List<Date>();
        ret.add(upperLeft);
        System.debug(upperLeft.daysBetween(upperLeft.addMonths(1).toStartOfMonth()));
        Date lowerRight = (upperLeft.Day() == 1 || upperLeft.daysBetween(upperLeft.addMonths(2).toStartOfMonth()) <= 35) ? upperLeft.addDays(5*7) : upperLeft.addDays(6*7);
        ret.add(lowerRight);
        return ret;
    }
    
    public String getMonthName() {
        return DateTime.newInstance(firstDate.year(),firstdate.month(),firstdate.day()).format('MMMM');
    }
    
    public String getYearName() {
        return DateTime.newInstance(
        firstDate.year(),firstdate.month(),firstdate.day()).format('yyyy');
    }
    
    public Date getfirstDate() { return firstDate; }
    
    public Month( Date value ) {
        weeks = new List<Week>();
        firstDate = value.toStartOfMonth();
        upperLeft = firstDate.toStartOfWeek();
        Date tmp = upperLeft;
        Integer numberOfWeeks = (upperLeft.Day() == 1 || upperLeft.daysBetween(upperLeft.addMonths(2).toStartOfMonth()) <= 35) ? 5 : 6;
            for (Integer i = 0; i < numberOfWeeks; i++) {
                Week w = new Week(i+1,tmp,value.month());
                system.assert(w!=null);
                this.weeks.add( w );
                tmp = tmp.addDays(7);
            }
    
    }
    
    public List<Week> getWeeks() {
        system.assert(weeks!=null,'could not create weeks list');
        return this.weeks;
    }
    
    
    /*
    * helper classes to define a month in terms of week and day
    */
    public class Week {
    public List<Day> days;
    public Integer weekNumber;
    public Date startingDate; // the date that the first of this week is on
    // so sunday of this week
    
    public List<Day> getDays() { return this.days; }
    
    public Week () {
        days = new List<Day>();
    }
    public Week(Integer value,Date sunday,Integer month) {
        this();
        weekNumber = value;
        startingDate = sunday;
        Date tmp = startingDate;
        for (Integer i = 0; i < 7; i++) {
        Day d = new Day( tmp,month );
        tmp = tmp.addDays(1);
        d.dayOfWeek = i+1;
        days.add(d);
    }
    
    }
    public Integer getWeekNumber() { return this.weekNumber;}
    public Date getStartingDate() { return this.startingDate;}
    
    }
    
    public class Day {
    
        public Date theDate;
        public Integer month, dayOfWeek;
        public String formatedDate; // for the formated time
        private String cssclass = 'calActive';
        
        public Date getDate() { return theDate; }
        public Integer getDayOfMonth() { return theDate.day(); }
        public String getDayOfMonth2() {
        if ( theDate.day() <= 9 )
        return '0'+theDate.day();
        return String.valueof( theDate.day());
        }
        public String getCSSName() { return cssclass; }
        
        public Day(Date value,Integer vmonth) {
        theDate=value; month=vmonth;
        formatedDate = '12 21 08';// time range..
        //9:00 AM - 1:00 PM
        // three possible Inactive,Today,Active
        if ( theDate.daysBetween(System.today()) == 0 ) cssclass ='calToday';
        // define inactive, is the date in the month?
        if ( theDate.month() != month) cssclass = 'calInactive';
        }
    
    }
}