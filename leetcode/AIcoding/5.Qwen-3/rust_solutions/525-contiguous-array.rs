impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn find_max_length(nums: Vec<i32>) -> i32 {
        let mut map = HashMap::new();
        map.insert(0, 0);
        let mut max_len = 0;
        let mut count = 0;

        for (i, &num) in nums.iter().enumerate() {
            count += if num == 1 { 1 } else { -1 };
            if let Some(&prev_index) = map.get(&count) {
                max_len = std::cmp::max(max_len, i as i32 - prev_index);
            } else {
                map.insert(count, i + 1);
            }
        }

        max_len
    }
}
}