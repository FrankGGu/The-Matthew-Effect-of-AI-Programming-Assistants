impl Solution {

use std::cmp::Ordering;

impl Solution {
    pub fn min_jumps(arr: Vec<i32>, start: i32, goal: i32) -> i32 {
        use std::collections::{HashSet, VecDeque};

        let n = arr.len();
        let start = start as usize;
        let goal = goal as usize;

        if start == goal {
            return 0;
        }

        let mut graph = std::collections::HashMap::new();
        for (i, &val) in arr.iter().enumerate() {
            graph.entry(val).or_insert_with(Vec::new).push(i);
        }

        let mut visited = HashSet::new();
        let mut queue = VecDeque::new();
        queue.push_back((start, 0));
        visited.insert(start);

        while let Some((current, steps)) = queue.pop_front() {
            for &neighbor in &graph[&arr[current]] {
                if neighbor == goal {
                    return steps + 1;
                }
                if !visited.contains(&neighbor) {
                    visited.insert(neighbor);
                    queue.push_back((neighbor, steps + 1));
                }
            }

            if current > 0 && !visited.contains(&(current - 1)) {
                visited.insert(current - 1);
                queue.push_back((current - 1, steps + 1));
            }

            if current < n - 1 && !visited.contains(&(current + 1)) {
                visited.insert(current + 1);
                queue.push_back((current + 1, steps + 1));
            }
        }

        -1
    }
}
}