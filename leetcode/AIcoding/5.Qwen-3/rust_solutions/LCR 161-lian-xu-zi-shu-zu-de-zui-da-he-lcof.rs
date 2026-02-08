impl Solution {

use std::collections::HashMap;

pub fn highest_sales_days(sales: Vec<i32>) -> Vec<i32> {
    let mut map = HashMap::new();
    let mut max_count = 0;
    let mut result = Vec::new();

    for &sale in &sales {
        *map.entry(sale).or_insert(0) += 1;
        max_count = std::cmp::max(max_count, map[&sale]);
    }

    for (&key, &value) in &map {
        if value == max_count {
            result.push(key);
        }
    }

    result.sort();
    result
}
}