impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn can_reorder_array(arr: Vec<i32>) -> bool {
        let mut count = HashMap::new();
        for &num in &arr {
            *count.entry(num).or_insert(0) += 1;
        }

        let mut keys: Vec<_> = count.keys().cloned().collect();
        keys.sort();

        for &num in &keys {
            if count[&num] == 0 {
                continue;
            }
            if num == 0 {
                if count[&num] % 2 != 0 {
                    return false;
                }
                continue;
            }
            let double = num * 2;
            if count.get(&double).unwrap_or(&0) < &count[&num] {
                return false;
            }
            count.entry(double).and_modify(|e| *e -= count[&num]);
            count.entry(num).and_modify(|e| *e -= count[&num]);
        }

        true
    }
}
}