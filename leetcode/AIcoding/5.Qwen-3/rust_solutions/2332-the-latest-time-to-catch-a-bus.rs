impl Solution {

use std::collections::VecDeque;

impl Solution {
    pub fn latest_time_to_catch_a_bus(buses: Vec<i32>, passengers: Vec<i32>) -> i32 {
        let mut buses = buses;
        let mut passengers = passengers;
        buses.sort();
        passengers.sort();

        let mut p = 0;
        let mut last_passenger_time = -1;

        for bus in &buses {
            while p < passengers.len() && passengers[p] <= *bus {
                last_passenger_time = passengers[p];
                p += 1;
            }
        }

        if p == 0 {
            return buses[0];
        }

        if last_passenger_time != buses.last().unwrap() {
            return buses.last().unwrap();
        }

        let mut time = buses.last().unwrap();
        while p > 0 && *time == passengers[p - 1] {
            time -= 1;
            p -= 1;
        }

        time
    }
}
}