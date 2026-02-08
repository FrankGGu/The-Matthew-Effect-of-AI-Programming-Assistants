impl Solution {

use std::cmp::Ordering;

struct Solution {}

impl Solution {
    pub fn reconstruct_queue(mut people: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
        people.sort_by(|a, b| {
            if b[0] != a[0] {
                b[0].cmp(&a[0])
            } else {
                a[1].cmp(&b[1])
            }
        });

        let mut result = Vec::new();
        for p in people {
            result.insert(p[1] as usize, p);
        }

        result
    }
}
}