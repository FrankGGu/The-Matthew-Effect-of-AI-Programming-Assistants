impl Solution {

use std::collections::HashMap;

struct Solution {}

impl Solution {
    pub fn number_of_ways(people: Vec<Vec<i32>>) -> i32 {
        let mut hat_to_people = HashMap::new();
        for (i, hats) in people.iter().enumerate() {
            for &h in hats {
                hat_to_people.entry(h).or_insert(Vec::new()).push(i);
            }
        }

        let mut dp = vec![0; 1 << people.len()];
        dp[0] = 1;

        for (&h, people_list) in hat_to_people {
            let mut new_dp = dp.clone();
            for mask in 0..(1 << people.len()) {
                if dp[mask] == 0 {
                    continue;
                }
                for &p in people_list {
                    if mask & (1 << p) == 0 {
                        new_dp[mask | (1 << p)] = (new_dp[mask | (1 << p)] + dp[mask]) % 1_000_000_007;
                    }
                }
            }
            dp = new_dp;
        }

        dp[(1 << people.len()) - 1]
    }
}
}