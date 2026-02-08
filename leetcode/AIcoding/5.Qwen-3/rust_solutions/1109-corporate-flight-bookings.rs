impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn corp_flight_bookings(n: i32, bookings: Vec<Vec<i32>>) -> Vec<i32> {
        let mut res = vec![0; n as usize];
        for booking in bookings {
            let start = booking[0] as usize - 1;
            let end = booking[1] as usize;
            let val = booking[2];
            res[start] += val;
            if end < n as usize {
                res[end] -= val;
            }
        }
        for i in 1..n as usize {
            res[i] += res[i - 1];
        }
        res
    }
}
}