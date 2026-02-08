impl Solution {

use std::collections::BinaryHeap;
use std::cmp::Reverse;

struct Solution;

impl Solution {
    pub fn find_crossing_time(mut n: i32, mut k: i32, time: Vec<Vec<i32>>) -> i32 {
        let mut workers = vec![];
        for i in 0..k {
            workers.push((time[i as usize][0], time[i as usize][1], time[i as usize][2], time[i as usize][3], i));
        }
        workers.sort_by(|a, b| a.0.cmp(&b.0).then(a.1.cmp(&b.1)));

        let mut on_left = BinaryHeap::new();
        let mut on_right = BinaryHeap::new();
        let mut waiting_left = BinaryHeap::new();
        let mut waiting_right = BinaryHeap::new();

        for (build_time, walk_time, get_time, put_time, id) in workers {
            on_left.push(Reverse((build_time, walk_time, get_time, put_time, id)));
        }

        let mut time_elapsed = 0;
        let mut result = 0;

        while n > 0 || !on_left.is_empty() || !on_right.is_empty() || !waiting_left.is_empty() || !waiting_right.is_empty() {
            while !on_left.is_empty() && on_left.peek().unwrap().0 .0 <= time_elapsed {
                let (build_time, walk_time, get_time, put_time, id) = on_left.pop().unwrap().0;
                waiting_left.push(Reverse((walk_time, build_time, get_time, put_time, id)));
            }

            while !on_right.is_empty() && on_right.peek().unwrap().0 .0 <= time_elapsed {
                let (build_time, walk_time, get_time, put_time, id) = on_right.pop().unwrap().0;
                waiting_right.push(Reverse((walk_time, build_time, get_time, put_time, id)));
            }

            if !waiting_left.is_empty() {
                let (walk_time, build_time, get_time, put_time, id) = waiting_left.pop().unwrap().0;
                time_elapsed += walk_time;
                on_right.push(Reverse((build_time, walk_time, get_time, put_time, id)));
                continue;
            }

            if !waiting_right.is_empty() {
                let (walk_time, build_time, get_time, put_time, id) = waiting_right.pop().unwrap().0;
                time_elapsed += walk_time;
                on_left.push(Reverse((build_time, walk_time, get_time, put_time, id)));
                continue;
            }

            if !on_left.is_empty() || !on_right.is_empty() {
                let next_time = on_left.peek().map(|x| x.0 .0).unwrap_or(i32::MAX);
                let next_time_right = on_right.peek().map(|x| x.0 .0).unwrap_or(i32::MAX);
                time_elapsed = time_elapsed.max(next_time.min(next_time_right));
            } else {
                time_elapsed += 1;
            }
        }

        result
    }
}
}