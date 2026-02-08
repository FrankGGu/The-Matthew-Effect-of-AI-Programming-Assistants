impl Solution {
    pub fn days_between_dates(date1: String, date2: String) -> i32 {
        use chrono::NaiveDate;
        let d1 = NaiveDate::parse_from_str(&date1, "%Y-%m-%d").unwrap();
        let d2 = NaiveDate::parse_from_str(&date2, "%Y-%m-%d").unwrap();
        let delta = d1.signed_duration_since(d2);
        delta.num_days() as i32
    }
}