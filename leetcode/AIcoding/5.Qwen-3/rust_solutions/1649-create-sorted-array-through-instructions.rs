impl Solution {

use std::cmp::Ordering;
use std::collections::BTreeSet;

impl Solution {
    pub fn create_sorted_array(instructions: Vec<i32>) -> i32 {
        let mut tree = BTreeSet::new();
        let mut result = 0;

        for &num in &instructions {
            let less = tree.range(..num).count() as i32;
            let greater = tree.range(num..).count() as i32;
            result += std::cmp::min(less, greater);
            tree.insert(num);
        }

        result
    }
}
}