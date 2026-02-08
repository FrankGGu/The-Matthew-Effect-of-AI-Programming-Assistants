impl Solution {

use std::collections::VecDeque;

impl Solution {
    pub fn find_max_score(mut cookies: Vec<i32>, mut k: i32) -> i32 {
        cookies.sort_unstable_by(|a, b| b.cmp(a));
        let mut max_score = 0;
        let mut queue = VecDeque::new();
        queue.push_back((vec![0; k as usize], 0));

        while let Some((mut distribution, index)) = queue.pop_front() {
            if index == cookies.len() {
                let score = distribution.iter().min().unwrap().clone();
                max_score = max_score.max(score);
                continue;
            }

            for i in 0..k as usize {
                if distribution[i] + cookies[index] >= max_score {
                    distribution[i] += cookies[index];
                    queue.push_back((distribution.clone(), index + 1));
                    distribution[i] -= cookies[index];
                }
            }
        }

        max_score
    }
}

struct Solution {}
}