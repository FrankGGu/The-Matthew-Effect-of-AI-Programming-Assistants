impl Solution {

use std::cmp::Ordering;

impl Solution {
    pub fn inventory_management(mut stock: Vec<i32>, cnt: i32) -> Vec<i32> {
        stock.sort_unstable();
        stock.into_iter().take(cnt as usize).collect()
    }
}
}