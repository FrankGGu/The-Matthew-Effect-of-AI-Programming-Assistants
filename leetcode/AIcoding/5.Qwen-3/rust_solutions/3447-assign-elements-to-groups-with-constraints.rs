impl Solution {

use std::collections::{HashMap, VecDeque};

impl Solution {
    pub fn group_elements(values: Vec<i32>, groups: Vec<Vec<i32>>) -> Vec<i32> {
        let mut value_to_group = HashMap::new();
        let mut group_to_values = HashMap::new();

        for (i, group) in groups.iter().enumerate() {
            for &value in group {
                value_to_group.insert(value, i as i32);
            }
        }

        for &value in &values {
            if !value_to_group.contains_key(&value) {
                return vec![-1];
            }
        }

        for (i, group) in groups.iter().enumerate() {
            group_to_values.insert(i as i32, Vec::new());
        }

        for &value in &values {
            let group_id = *value_to_group.get(&value).unwrap();
            group_to_values.get_mut(&group_id).unwrap().push(value);
        }

        let mut result = Vec::new();
        for group in groups {
            for &value in &group {
                result.push(*value_to_group.get(&value).unwrap());
            }
        }

        result
    }
}
}