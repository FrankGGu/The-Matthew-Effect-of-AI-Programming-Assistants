impl Solution {

use std::collections::HashMap;

struct Solution;

impl Solution {
    pub fn count_mentions_per_user(mentions: Vec<String>) -> HashMap<String, i32> {
        let mut counts = HashMap::new();
        for mention in mentions {
            let user = &mention[1..];
            *counts.entry(user.to_string()).or_insert(0) += 1;
        }
        counts
    }
}
}