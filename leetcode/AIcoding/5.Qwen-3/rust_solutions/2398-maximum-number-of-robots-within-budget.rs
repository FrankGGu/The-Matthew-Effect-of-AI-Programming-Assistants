impl Solution {

use std::cmp::Reverse;
use std::collections::BinaryHeap;

impl Solution {
    pub fn maximum_number_of_robots(mut robot_costs: Vec<i32>, mut robot_times: Vec<i32>, budget: i32) -> i32 {
        let n = robot_costs.len();
        let mut robots = Vec::with_capacity(n);
        for i in 0..n {
            robots.push((robot_costs[i], robot_times[i], i));
        }
        robots.sort_by(|a, b| a.0.cmp(&b.0));

        let mut time_heap = BinaryHeap::new();
        let mut total_time = 0;
        let mut count = 0;

        for i in 0..n {
            let cost = robots[i].0;
            let time = robots[i].1;

            if total_time + time > budget {
                while let Some(&t) = time_heap.peek() {
                    if total_time - t + time <= budget {
                        total_time -= t;
                        time_heap.pop();
                        total_time += time;
                        time_heap.push(time);
                        break;
                    } else {
                        time_heap.pop();
                        total_time -= t;
                    }
                }
            } else {
                time_heap.push(time);
                total_time += time;
            }

            if total_time <= budget {
                count += 1;
            }
        }

        count
    }
}
}