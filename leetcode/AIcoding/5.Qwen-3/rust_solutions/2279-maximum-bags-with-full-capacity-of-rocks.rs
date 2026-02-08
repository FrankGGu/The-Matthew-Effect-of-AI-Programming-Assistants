impl Solution {

use std::cmp::Reverse;

impl Solution {
    pub fn maximum_bags(mut capacity: Vec<i32>, mut rocks: Vec<i32>, mut additional_rocks: i32) -> i32 {
        let mut diffs = capacity.iter().zip(rocks.iter()).map(|(&c, &r)| c - r).collect::<Vec<_>>();
        diffs.sort_by_key(|&d| Reverse(d));

        let mut count = 0;
        for d in diffs {
            if d <= 0 {
                count += 1;
            } else if additional_rocks >= d {
                additional_rocks -= d;
                count += 1;
            } else {
                break;
            }
        }

        count
    }
}
}