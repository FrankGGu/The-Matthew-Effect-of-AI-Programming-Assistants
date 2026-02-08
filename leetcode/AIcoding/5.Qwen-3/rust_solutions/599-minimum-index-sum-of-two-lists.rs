impl Solution {

use std::collections::HashMap;

fn main() {}

fn find_restaurant(list1: Vec<&str>, list2: Vec<&str>) -> Vec<String> {
    let mut map = HashMap::new();
    for (i, &s) in list1.iter().enumerate() {
        map.insert(s, i);
    }

    let mut min_sum = usize::MAX;
    let mut result = Vec::new();

    for (j, &s) in list2.iter().enumerate() {
        if let Some(&i) = map.get(s) {
            let sum = i + j;
            if sum < min_sum {
                min_sum = sum;
                result.clear();
                result.push(s.to_string());
            } else if sum == min_sum {
                result.push(s.to_string());
            }
        }
    }

    result
}
}