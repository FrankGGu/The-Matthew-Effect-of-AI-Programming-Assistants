impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn array_rank_transform(arr: Vec<i32>) -> Vec<i32> {
        let mut sorted: Vec<i32> = arr.clone();
        sorted.sort();
        let mut rank_map = HashMap::new();
        let mut rank = 1;
        for &num in &sorted {
            if !rank_map.contains_key(&num) {
                rank_map.insert(num, rank);
                rank += 1;
            }
        }
        let mut result = Vec::with_capacity(arr.len());
        for &num in &arr {
            result.push(*rank_map.get(&num).unwrap());
        }
        result
    }
}
}