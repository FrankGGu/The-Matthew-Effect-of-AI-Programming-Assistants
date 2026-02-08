impl Solution {

use std::collections::BTreeSet;

impl Solution {
    pub fn can_be_sorted(nums: Vec<i32>) -> bool {
        let mut sorted = nums.clone();
        sorted.sort();

        let mut groups = BTreeSet::new();
        let mut current_group = vec![];

        for num in nums {
            current_group.push(num);
            if current_group.len() > 1 && current_group[current_group.len() - 2] > current_group[current_group.len() - 1] {
                groups.insert(current_group.clone());
                current_group.clear();
                current_group.push(num);
            }
        }
        groups.insert(current_group);

        let mut result = vec![];
        for group in groups {
            result.extend(group);
        }

        result == sorted
    }
}
}