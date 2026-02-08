impl Solution {

use std::collections::HashMap;

struct Solution {}

impl Solution {
    pub fn min_chairs(vehicles: Vec<&str>) -> i32 {
        let mut count = 0;
        let mut max_count = 0;
        let mut map = HashMap::new();
        map.insert("car", 1);
        map.insert("motorcycle", 1);
        map.insert("bus", 3);
        map.insert("truck", 3);

        for &vehicle in &vehicles {
            let val = *map.get(vehicle).unwrap_or(&1);
            count += val;
            if count > max_count {
                max_count = count;
            }
        }

        max_count
    }
}
}