pub fn day_of_the_week(day: i32, month: i32, year: i32) -> String {
    use chrono::prelude::*;
    let date = NaiveDate::from_ymd_opt(year as i32, month as u32, day as u32).unwrap();
    let weekday = date.weekday();
    match weekday {
        chrono::Weekday::Mon => "Monday".to_string(),
        chrono::Weekday::Tue => "Tuesday".to_string(),
        chrono::Weekday::Wed => "Wednesday".to_string(),
        chrono::Weekday::Thu => "Thursday".to_string(),
        chrono::Weekday::Fri => "Friday".to_string(),
        chrono::Weekday::Sat => "Saturday".to_string(),
        chrono::Weekday::Sun => "Sunday".to_string(),
    }
}