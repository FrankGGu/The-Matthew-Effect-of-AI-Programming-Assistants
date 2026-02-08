impl Solution {

use std::collections::BTreeSet;

impl Solution {
    pub fn contains_nearby_almost_duplicate(nums: Vec<i32>, k: i32, t: i32) -> bool {
        let mut window = BTreeSet::new();
        for (i, &num) in nums.iter().enumerate() {
            if i > k as usize {
                window.remove(&nums[i - k as usize - 1]);
            }
            let bucket = num / ((t as i64 + 1) as i32);
            if window.contains(&bucket) {
                return true;
            }
            if let Some(left) = window.range(..bucket).next_back() {
                if (num as i64 - *left as i64).abs() <= t as i64 {
                    return true;
                }
            }
            if let Some(right) = window.range(bucket..).next() {
                if (*right as i64 - num as i64).abs() <= t as i64 {
                    return true;
                }
            }
            window.insert(bucket);
        }
        false
    }
}
}