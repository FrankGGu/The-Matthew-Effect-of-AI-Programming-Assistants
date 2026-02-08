impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn find_diagonal_order(nums: Vec<Vec<i32>>) -> Vec<i32> {
        let mut map = HashMap::new();
        for (i, row) in nums.iter().enumerate() {
            for (j, &num) in row.iter().enumerate() {
                let key = i + j;
                map.entry(key).or_insert_with(Vec::new);
                map.get_mut(&key).unwrap().push(num);
            }
        }
        let mut result = Vec::new();
        for (_, mut values) in map {
            values.reverse();
            result.extend(values);
        }
        result
    }
}
}