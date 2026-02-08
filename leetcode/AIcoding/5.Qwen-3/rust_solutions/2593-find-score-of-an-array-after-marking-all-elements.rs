impl Solution {

use std::collections::HashSet;

struct Solution {}

impl Solution {
    pub fn find_score(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut marked = HashSet::new();
        let mut score = 0;
        let mut nums_with_indices = nums.iter().enumerate().collect::<Vec<_>>();

        nums_with_indices.sort_by(|a, b| a.1.cmp(b.1));

        for (i, &val) in nums_with_indices.iter() {
            if !marked.contains(i) {
                score += val;
                if i > 0 {
                    marked.insert(i - 1);
                }
                if i < n - 1 {
                    marked.insert(i + 1);
                }
            }
        }

        score
    }
}
}