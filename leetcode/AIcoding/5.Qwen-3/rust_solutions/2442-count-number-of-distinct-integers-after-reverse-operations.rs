impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn count_distinct_integers(mut nums: Vec<i32>) -> i32 {
        let mut set = HashSet::new();
        for num in &nums {
            set.insert(*num);
            let reversed = reverse_number(*num);
            set.insert(reversed);
        }
        set.len() as i32
    }
}

fn reverse_number(mut num: i32) -> i32 {
    let mut reversed = 0;
    while num > 0 {
        reversed = reversed * 10 + num % 10;
        num /= 10;
    }
    reversed
}
}