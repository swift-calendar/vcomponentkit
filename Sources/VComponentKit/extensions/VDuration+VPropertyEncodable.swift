//    4.3.6   Duration
//
//       Value Name: DURATION
//
//       Purpose: This value type is used to identify properties that contain
//       a duration of time.
//
//       Formal Definition: The value type is defined by the following
//       notation:
//
//         dur-value  = (["+"] / "-") "P" (dur-date / dur-time / dur-week)
//
//         dur-date   = dur-day [dur-time]
//         dur-time   = "T" (dur-hour / dur-minute / dur-second)
//         dur-week   = 1*DIGIT "W"
//         dur-hour   = 1*DIGIT "H" [dur-minute]
//         dur-minute = 1*DIGIT "M" [dur-second]
//         dur-second = 1*DIGIT "S"
//         dur-day    = 1*DIGIT "D"
//
//       Description: If the property permits, multiple "duration" values are
//       specified by a COMMA character (US-ASCII decimal 44) separated list
//       of values. The format is expressed as the [ISO 8601] basic format for
//       the duration of time. The format can represent durations in terms of
//       weeks, days, hours, minutes, and seconds.
//    No additional content value encoding (i.e., BACKSLASH character
//    encoding) are defined for this value type.
//
//    Example: A duration of 15 days, 5 hours and 20 seconds would be:
//
//      P15DT5H0M20S
//
//    A duration of 7 weeks would be:
//
//      P7W
//
//    https://www.rfc-editor.org/rfc/rfc2445.txt

public enum VDurationDirection: VPropertyEncodable {
    /// The + sign can be ignored because is the default value
    case plus
    case minus
    
    public var vEncoded: String {
        switch self {
            case .plus:
                return ""
            case .minus:
                return "-"
        }
    }
}

public struct VDurationDay: VPropertyEncodable {
    public var weeks: Int
    public var days: Int
    
    public var vEncoded: String {
        var str = "P"
            
        if weeks != 0 {
            str.append("\(weeks)W")
        }
        
        if days != 0 {
            str.append("\(days)D")
        }
        
        return str
    }
    
    public init() {
        self.weeks = 0
        self.days = 0
    }
    
    public init(days: Int = 0) {
        guard days > -1 else {
            fatalError("""
                Weeks or days can only be positive,
                to change direction use VDurationDirection
                block in the VDuration init
            """)
        }
        
        self.weeks = 0
        self.days = days
    }
    
    public init(weeks: Int = 0) {
        guard weeks > -1 else {
            fatalError("""
                Weeks or days can only be positive,
                to change direction use VDurationDirection
                block in the VDuration init
            """)
        }
        
        self.weeks = weeks
        self.days = 0
    }
}

public struct VDurationTime: VPropertyEncodable {
    public var hours: Int
    public var minutes: Int
    public var seconds: Int
    
    public var vEncoded: String {
        guard hours != 0 || minutes != 0 || seconds != 0 else { return "" }
        
        var str = "T"
        
        if hours != 0 && minutes == 0 && seconds == 0 {
            str.append("\(hours)H")
        } else if hours != 0 && minutes != 0 && seconds == 0 {
            str.append("\(hours)H\(minutes)M")
        } else {
            str.append("\(hours)H\(minutes)M\(seconds)S")
        }
        
        return str
    }
    
    public init(hours: Int = 0, minutes: Int = 0, seconds: Int = 0) {
        guard hours > -1 && minutes > -1 && seconds > -1 else {
            fatalError("""
                Hours, minutes or seconds can only be positive,
                to change direction use VDurationDirection
                block in the VDuration init
            """)
        }
        
        self.hours = hours
        self.minutes = minutes
        self.seconds = seconds
    }
}

public struct VDuration: VPropertyEncodable {
    public var durationDirection: VDurationDirection
    public var durationDay: VDurationDay
    public var durationTime: VDurationTime
    
    public var vEncoded: String {
        durationDirection.vEncoded + durationDay.vEncoded + durationTime.vEncoded
    }
    
    public init() {
        self.durationDirection = .plus
        self.durationDay = VDurationDay()
        self.durationTime = VDurationTime()
    }
    
    public init(_ durationDay: VDurationDay) {
        self.durationDirection = .plus
        self.durationDay = durationDay
        self.durationTime = VDurationTime()
    }
    
    public init(_ durationTime: VDurationTime) {
        self.durationDirection = .plus
        self.durationDay = VDurationDay()
        self.durationTime = durationTime
    }
    
    public init(_ durationDay: VDurationDay, _ durationTime: VDurationTime = VDurationTime()) {
        self.durationDirection = .plus
        self.durationDay = durationDay
        self.durationTime = durationTime
    }
    
    public init(durationDirection: VDurationDirection = .plus, durationDay: VDurationDay, durationTime: VDurationTime = VDurationTime()) {
        self.durationDirection = durationDirection
        self.durationDay = durationDay
        self.durationTime = durationTime
    }
}
