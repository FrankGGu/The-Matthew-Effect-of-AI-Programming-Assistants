impl Solution {

use std::collections::HashSet;

struct Solution {}

impl Solution {
    pub fn count_colors(balls: Vec<Vec<i32>>) -> i32 {
        let mut colors = HashSet::new();
        for ball in balls {
            for color in ball {
                colors.insert(color);
            }
        }
        colors.len() as i32
    }
}
}