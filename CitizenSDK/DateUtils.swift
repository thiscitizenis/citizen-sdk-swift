import Foundation

public struct DateUtils
{
    public static func importFromJodaString(jodaString: String) -> Date? {
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        let date: Date? = formatter.date(from: jodaString)
        
        return date
    }
    
    public static func importFromJodaOptionalString(jodaString: String?) -> Date? {
        if jodaString == nil {
            return nil
        }
        
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        let date: Date? = formatter.date(from: jodaString!)
        
        return date
    }
    
    public static func exportToJodaString(date: Date) -> String {
        let calender: Calendar = Calendar.current
        
        let year: String = String(format: "%04d", calender.component(.year, from: date))
        let month: String = String(format: "%02d", calender.component(.month, from: date))
        let day: String = String(format: "%02d", calender.component(.day, from: date))
        let hour: String = String(format:"%02d", calender.component(.hour, from: date))
        let minute: String = String(format: "%02d", calender.component(.minute, from: date))
        let second: String = String(format: "%02d", calender.component(.second, from: date))
        
        let jodaString: String = year + "-" + month + "-" + day + "T" +
                                 hour + ":" + minute + ":" + second + ".000Z"
        
        return jodaString
    }
}
