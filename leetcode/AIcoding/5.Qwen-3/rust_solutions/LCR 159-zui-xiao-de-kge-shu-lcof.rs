impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn inventory_management(warehouse: Vec<i32>, cnt: i32) -> Vec<i32> {
        let mut set = HashSet::new();
        let mut result = Vec::new();
        for &num in &warehouse {
            if !set.contains(&num) {
                set.insert(num);
                result.push(num);
                if result.len() as i32 == cnt {
                    break;
                }
            }
        }
        result
    }
}
}