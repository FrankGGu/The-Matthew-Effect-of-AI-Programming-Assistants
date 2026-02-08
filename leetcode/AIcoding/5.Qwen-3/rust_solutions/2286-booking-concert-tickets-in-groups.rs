impl Solution {

use std::collections::BTreeSet;

struct Bookings {
    seats: BTreeSet<i32>,
}

impl Bookings {
    fn new(n: i32) -> Self {
        let mut seats = BTreeSet::new();
        for i in 1..=n {
            seats.insert(i);
        }
        Bookings { seats }
    }

    fn book(self: &mut Self, k: i32, max_row: i32) -> Vec<i32> {
        let mut result = Vec::new();
        let mut rows = 0;
        let mut current = 1;

        while rows < k {
            let mut count = 0;
            let mut start = -1;

            while current <= max_row && count < k {
                let row_start = current * 1000;
                let mut available = 0;

                for seat in &self.seats {
                    if *seat >= row_start && *seat < row_start + 1000 {
                        available += 1;
                    }
                }

                if available >= k {
                    start = current;
                    break;
                }

                current += 1;
                count += 1;
            }

            if start == -1 {
                return vec![];
            }

            let row_start = start * 1000;
            for i in 0..k {
                self.seats.remove(&(row_start + i));
            }

            result.push(start);
            rows += 1;
        }

        result
    }
}

pub fn book_tickets(n: i32, k: i32, max_row: i32) -> Vec<i32> {
    let mut bookings = Bookings::new(n);
    bookings.book(k, max_row)
}
}