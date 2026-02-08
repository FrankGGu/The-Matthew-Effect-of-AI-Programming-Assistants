impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn minimum_swaps(mut nums: Vec<i32>) -> i32 {
        let mut map = HashMap::new();
        for (i, &num) in nums.iter().enumerate() {
            let sum = digit_sum(num);
            map.entry(sum).or_insert(vec![]);
            map.get_mut(&sum).unwrap().push(i);
        }

        let mut sorted = nums.clone();
        sorted.sort();

        let mut swaps = 0;
        let mut used = vec![false; nums.len()];

        for i in 0..nums.len() {
            if used[i] || nums[i] == sorted[i] {
                continue;
            }

            let mut cycle_size = 0;
            let mut j = i;
            while !used[j] && nums[j] != sorted[j] {
                used[j] = true;
                j = map.get(&digit_sum(nums[j])).unwrap()[0];
                cycle_size += 1;
            }

            if cycle_size > 0 {
                swaps += cycle_size - 1;
            }
        }

        swaps
    }
}

fn digit_sum(mut n: i32) -> i32 {
    let mut sum = 0;
    while n > 0 {
        sum += n % 10;
        n /= 10;
    }
    sum
}
}