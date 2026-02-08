impl Solution {

use std::collections::{HashMap, VecDeque};

impl Solution {
    pub fn num_of_minutes(n: i32, head_id: i32, manager: Vec<i32>, inform_time: Vec<i32>) -> i32 {
        let mut graph: HashMap<i32, Vec<i32>> = HashMap::new();
        for (i, &m) in manager.iter().enumerate() {
            graph.entry(m).or_insert_with(Vec::new).push(i as i32);
        }

        let mut queue = VecDeque::new();
        queue.push_back((head_id, 0));
        let mut max_time = 0;

        while let Some((employee, time)) = queue.pop_front() {
            max_time = std::cmp::max(max_time, time);
            if let Some(subordinates) = graph.get(&employee) {
                for &sub in subordinates {
                    queue.push_back((sub, time + inform_time[employee as usize]));
                }
            }
        }

        max_time
    }
}
}