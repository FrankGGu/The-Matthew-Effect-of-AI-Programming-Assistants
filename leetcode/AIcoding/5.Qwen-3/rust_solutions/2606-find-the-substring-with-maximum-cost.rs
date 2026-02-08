impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn max_cost(s: String, cost: Vec<i32>, k: i32) -> i32 {
        let mut max_cost = 0;
        let mut count = HashMap::new();
        let mut left = 0;
        let mut current_cost = 0;

        for right in 0..s.len() {
            let c = s.chars().nth(right).unwrap();
            let c_cost = cost[right];

            if count.contains_key(&c) {
                current_cost -= count[&c];
            }
            count.insert(c, c_cost);
            current_cost += c_cost;

            while count.len() > k as usize {
                let left_c = s.chars().nth(left).unwrap();
                current_cost -= count[&left_c];
                count.remove(&left_c);
                left += 1;
            }

            max_cost = std::cmp::max(max_cost, current_cost);
        }

        max_cost
    }
}
}