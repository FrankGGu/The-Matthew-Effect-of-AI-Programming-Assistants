impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn min_operations(nums: Vec<i32>) -> i32 {
        if nums.len() == 1 {
            return 0;
        }

        let mut freq = HashMap::new();
        let mut even_freq = HashMap::new();
        let mut odd_freq = HashMap::new();

        for (i, &num) in nums.iter().enumerate() {
            *freq.entry(num).or_insert(0) += 1;
            if i % 2 == 0 {
                *even_freq.entry(num).or_insert(0) += 1;
            } else {
                *odd_freq.entry(num).or_insert(0) += 1;
            }
        }

        let mut even_candidates = even_freq.into_iter().collect::<Vec<_>>();
        even_candidates.sort_by(|a, b| b.1.cmp(&a.1));
        let mut odd_candidates = odd_freq.into_iter().collect::<Vec<_>>();
        odd_candidates.sort_by(|a, b| b.1.cmp(&a.1));

        if even_candidates[0].0 != odd_candidates[0].0 {
            return nums.len() as i32 - even_candidates[0].1 - odd_candidates[0].1;
        } else {
            let even_second = if even_candidates.len() > 1 { even_candidates[1].1 } else { 0 };
            let odd_second = if odd_candidates.len() > 1 { odd_candidates[1].1 } else { 0 };
            return nums.len() as i32 - std::cmp::max(even_second, odd_second);
        }
    }
}
}