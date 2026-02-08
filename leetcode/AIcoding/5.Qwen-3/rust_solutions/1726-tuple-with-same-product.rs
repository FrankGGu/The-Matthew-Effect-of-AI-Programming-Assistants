impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn unique_partition(nums: Vec<i32>) -> i32 {
        let mut seen = HashSet::new();
        let mut count = 0;

        for i in 0..nums.len() {
            for j in i+1..nums.len() {
                for k in 0..nums.len() {
                    if k == i || k == j {
                        continue;
                    }
                    for l in k+1..nums.len() {
                        if l == i || l == j {
                            continue;
                        }
                        let product = nums[i] * nums[j];
                        let other_product = nums[k] * nums[l];
                        if product == other_product {
                            let tuple = (nums[i], nums[j], nums[k], nums[l]);
                            let sorted = if nums[i] <= nums[k] { tuple } else { (nums[k], nums[l], nums[i], nums[j]) };
                            if !seen.contains(&sorted) {
                                seen.insert(sorted);
                                count += 1;
                            }
                        }
                    }
                }
            }
        }

        count
    }
}
}