impl Solution {

use std::collections::HashMap;

struct Solution {}

impl Solution {
    pub fn sum_even_after_queries(mut nums: Vec<i32>, queries: Vec<Vec<i32>>) -> Vec<i32> {
        let mut even_sum = 0;
        for &num in &nums {
            if num % 2 == 0 {
                even_sum += num;
            }
        }

        let mut result = Vec::new();
        for query in queries {
            let index = query[0] as usize;
            let val = query[1];

            if nums[index] % 2 == 0 {
                even_sum -= nums[index];
            }

            nums[index] += val;

            if nums[index] % 2 == 0 {
                even_sum += nums[index];
            }

            result.push(even_sum);
        }

        result
    }
}
}