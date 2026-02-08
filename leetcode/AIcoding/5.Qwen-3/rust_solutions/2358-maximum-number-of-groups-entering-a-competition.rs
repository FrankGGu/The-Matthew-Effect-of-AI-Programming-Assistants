impl Solution {

use std::collections::HashMap;

struct Solution {}

impl Solution {
    pub fn max_competing_groups(mut grades: Vec<i32>) -> i32 {
        grades.sort();
        let mut count = HashMap::new();
        for &g in &grades {
            *count.entry(g).or_insert(0) += 1;
        }
        let mut res = 0;
        let mut prev = -1;
        for (i, &g) in grades.iter().enumerate() {
            if g != prev {
                let mut cnt = 0;
                let mut j = i;
                while j < grades.len() && grades[j] == g {
                    cnt += 1;
                    j += 1;
                }
                if cnt >= 3 {
                    res += 1;
                }
                prev = g;
            }
        }
        res
    }
}
}