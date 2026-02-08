impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn max_subarrays(arr: Vec<i32>) -> i32 {
        let mut prefix_sum = 0;
        let mut count = 0;
        let mut map = HashMap::new();
        map.insert(0, -1);

        for (i, &num) in arr.iter().enumerate() {
            prefix_sum += num;
            if let Some(&j) = map.get(&prefix_sum) {
                if i - j > 1 {
                    count += 1;
                    map.clear();
                    map.insert(0, i as i32);
                    prefix_sum = 0;
                }
            } else {
                map.insert(prefix_sum, i as i32);
            }
        }

        count
    }
}
}