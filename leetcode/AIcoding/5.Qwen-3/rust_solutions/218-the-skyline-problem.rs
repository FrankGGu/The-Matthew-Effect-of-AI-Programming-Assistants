impl Solution {

use std::collections::VecDeque;

struct Solution;

impl Solution {
    pub fn get_skyline(mut buildings: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
        let mut events = Vec::new();
        for building in &buildings {
            events.push((building[0], -building[2]));
            events.push((building[1], building[2]));
        }
        events.sort();

        let mut result = Vec::new();
        let mut prev_height = 0;
        let mut curr_height = 0;
        let mut heap = std::collections::BinaryHeap::new();

        let mut i = 0;
        while i < events.len() {
            let (x, h) = events[i];
            while i < events.len() && events[i].0 == x {
                if h < 0 {
                    heap.push(h);
                } else {
                    heap.retain(|&val| val != h);
                }
                i += 1;
            }

            curr_height = if heap.is_empty() { 0 } else { *heap.peek().unwrap() };
            if curr_height != prev_height {
                result.push(vec![x, curr_height]);
                prev_height = curr_height;
            }
        }

        result
    }
}
}