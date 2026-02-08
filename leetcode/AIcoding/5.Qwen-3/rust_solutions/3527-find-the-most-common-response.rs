impl Solution {

use std::collections::HashMap;

struct Solution;

impl Solution {
    pub fn most_common_response(responses: Vec<&str>, k: i32) -> String {
        let mut counts = HashMap::new();
        for &response in &responses {
            *counts.entry(response).or_insert(0) += 1;
        }

        let mut counts_vec: Vec<_> = counts.into_iter().collect();
        counts_vec.sort_by(|a, b| {
            if b.1 != a.1 {
                b.1.cmp(&a.1)
            } else {
                a.0.cmp(b.0)
            }
        });

        counts_vec[k as usize - 1].0.to_string()
    }
}
}