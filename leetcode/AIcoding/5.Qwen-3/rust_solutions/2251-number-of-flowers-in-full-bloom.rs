impl Solution {

use std::collections::BTreeSet;

struct Solution {}

impl Solution {
    pub fn number_of_flowers(friends: Vec<Vec<i32>>, flowers: Vec<Vec<i32>>) -> Vec<i32> {
        let mut start_times = BTreeSet::new();
        let mut end_times = BTreeSet::new();

        for flower in &flowers {
            start_times.insert(flower[0]);
            end_times.insert(flower[1]);
        }

        let mut result = vec![];

        for friend in &friends {
            let time = friend[0];
            let start_count = start_times.range(..=time).count() as i32;
            let end_count = end_times.range(..time).count() as i32;
            result.push(start_count - end_count);
        }

        result
    }
}
}