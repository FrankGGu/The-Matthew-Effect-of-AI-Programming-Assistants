impl Solution {

use std::collections::HashMap;

fn main() {}

fn find_relative_ranks(score: Vec<i32>) -> Vec<String> {
    let mut sorted_scores = score.clone();
    sorted_scores.sort_by(|a, b| b.cmp(a));

    let mut rank_map = HashMap::new();
    for (i, &s) in sorted_scores.iter().enumerate() {
        match i {
            0 => rank_map.insert(s, "Gold Medal".to_string()),
            1 => rank_map.insert(s, "Silver Medal".to_string()),
            2 => rank_map.insert(s, "Bronze Medal".to_string()),
            _ => rank_map.insert(s, (i + 1).to_string()),
        };
    }

    score.iter().map(|&s| rank_map.get(&s).unwrap().clone()).collect()
}
}