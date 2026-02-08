impl Solution {

use std::collections::{BinaryHeap, HashMap};

struct Solution {}

impl Solution {
    pub fn most_booked(n: i32, times: Vec<Vec<i32>>) -> i32 {
        let n = n as usize;
        let mut available = (0..n).collect::<BinaryHeap<_>>();
        let mut ending = BinaryHeap::new();
        let mut events = times.into_iter().enumerate().collect::<Vec<_>>();

        events.sort_by_key(|&(_, ref time)| time[0]);

        for (i, time) in events {
            while let Some((end_time, chair)) = ending.peek() {
                if *end_time <= time[0] {
                    ending.pop();
                    available.push(*chair);
                } else {
                    break;
                }
            }

            if let Some(chair) = available.pop() {
                ending.push((time[1], chair));
            } else {
                let (end_time, chair) = ending.pop().unwrap();
                ending.push((time[1], chair));
            }
        }

        available.into_iter().last().unwrap() as i32
    }
}
}