impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn distribute_elements(mut nums: Vec<i32>) -> Vec<i32> {
        let mut count = HashMap::new();
        for &num in &nums {
            *count.entry(num).or_insert(0) += 1;
        }

        let mut arr1 = Vec::new();
        let mut arr2 = Vec::new();

        for num in nums {
            if count[&num] % 2 == 0 {
                arr1.push(num);
            } else {
                arr2.push(num);
            }
            *count.get_mut(&num).unwrap() -= 1;
        }

        arr1.into_iter().chain(arr2).collect()
    }
}
}