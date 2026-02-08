impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn count_almost_equal_pairs(nums: Vec<i32>) -> i32 {
        fn get_signature(mut num: i32) -> String {
            let mut freq = vec![0; 10];
            while num > 0 {
                freq[num as usize % 10] += 1;
                num /= 10;
            }
            freq.iter().map(|&x| x.to_string()).collect::<String>()
        }

        let mut map = HashMap::new();
        for &num in &nums {
            let sig = get_signature(num);
            *map.entry(sig).or_insert(0) += 1;
        }

        let mut result = 0;
        for count in map.values() {
            result += count * (count - 1) / 2;
        }

        result
    }
}
}