impl Solution {

use std::cmp::Ordering;

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
struct Date {
    month: i32,
    day: i32,
}

impl Date {
    fn new(month: i32, day: i32) -> Self {
        Date { month, day }
    }

    fn to_days(&self) -> i32 {
        let days_in_month = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
        let mut total = 0;
        for i in 0..(self.month - 1) {
            total += days_in_month[i as usize];
        }
        total + self.day
    }
}

fn count_days_together(a_date: String, a_date2: String, b_date: String, b_date2: String) -> i32 {
    let parse_date = |s: &str| {
        let parts: Vec<&str> = s.split('-').collect();
        Date::new(parts[0].parse().unwrap(), parts[1].parse().unwrap())
    };

    let a1 = parse_date(&a_date);
    let a2 = parse_date(&a_date2);
    let b1 = parse_date(&b_date);
    let b2 = parse_date(&b_date2);

    let a_start = a1.to_days();
    let a_end = a2.to_days();
    let b_start = b1.to_days();
    let b_end = b2.to_days();

    let overlap_start = a_start.max(b_start);
    let overlap_end = a_end.min(b_end);

    if overlap_start > overlap_end {
        0
    } else {
        overlap_end - overlap_start + 1
    }
}
}