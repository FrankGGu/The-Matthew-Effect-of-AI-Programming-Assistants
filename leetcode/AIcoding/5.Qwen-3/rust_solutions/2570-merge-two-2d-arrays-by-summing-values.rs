impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn merge_arrays(
        nums1: Vec<Vec<i32>>,
        nums2: Vec<Vec<i32>>,
    ) -> Vec<Vec<i32>> {
        let mut map = HashMap::new();

        for arr in nums1 {
            let key = arr[0];
            let val = arr[1];
            *map.entry(key).or_insert(0) += val;
        }

        for arr in nums2 {
            let key = arr[0];
            let val = arr[1];
            *map.entry(key).or_insert(0) += val;
        }

        let mut result: Vec<Vec<i32>> = map
            .into_iter()
            .map(|(k, v)| vec![k, v])
            .collect();

        result.sort_by(|a, b| a[0].cmp(&b[0]));

        result
    }
}
}