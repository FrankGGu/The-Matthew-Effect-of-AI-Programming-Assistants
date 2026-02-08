impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn min_cost(start: String, target: String, cost: Vec<i32>) -> i32 {
        if start.len() != target.len() {
            return -1;
        }

        let mut char_map = HashMap::new();
        for i in 0..start.len() {
            let c = start.chars().nth(i).unwrap();
            let t = target.chars().nth(i).unwrap();
            if c != t {
                char_map.entry(c).or_insert_with(Vec::new).push((t, cost[i]));
            }
        }

        let mut visited = HashMap::new();
        let mut queue = std::collections::VecDeque::new();
        queue.push_back((start.chars().next().unwrap(), 0));
        visited.insert(start.chars().next().unwrap(), 0);

        while let Some((c, cost_so_far)) = queue.pop_front() {
            if c == target.chars().next().unwrap() {
                return cost_so_far;
            }

            if let Some(neighbors) = char_map.get(&c) {
                for &(next_char, next_cost) in neighbors {
                    let new_cost = cost_so_far + next_cost;
                    if !visited.contains_key(&next_char) || new_cost < *visited.get(&next_char).unwrap() {
                        visited.insert(next_char, new_cost);
                        queue.push_back((next_char, new_cost));
                    }
                }
            }
        }

        -1
    }
}
}