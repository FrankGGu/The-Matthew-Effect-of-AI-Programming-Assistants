impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn remove_anagrams(nums: Vec<i32>) -> Vec<i32> {
        let mut result = Vec::new();
        let mut prev_count = HashMap::new();

        for num in nums {
            let mut count = HashMap::new();
            let mut temp = num;
            while temp > 0 {
                let digit = temp % 10;
                *count.entry(digit).or_insert(0) += 1;
                temp /= 10;
            }

            if prev_count != count {
                result.push(num);
                prev_count = count;
            }
        }

        result
    }
}
}