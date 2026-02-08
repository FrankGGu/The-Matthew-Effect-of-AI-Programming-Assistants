impl Solution {

use std::collections::HashMap;

struct Solution;

impl Solution {
    pub fn min_operations(ingredients: Vec<Vec<i32>>, target: i32) -> i32 {
        let mut count = HashMap::new();
        for &ing in &ingredients[0] {
            *count.entry(ing).or_insert(0) += 1;
        }

        for i in 1..ingredients.len() {
            let mut new_count = HashMap::new();
            for &ing in &ingredients[i] {
                *new_count.entry(ing).or_insert(0) += 1;
            }
            for (k, v) in &mut count {
                if let Some(&nv) = new_count.get(k) {
                    *v = std::cmp::min(*v, nv);
                } else {
                    *v = 0;
                }
            }
        }

        let mut res = 0;
        for &ing in &ingredients[0] {
            if count[&ing] == 0 {
                return -1;
            }
        }

        for &ing in &ingredients[0] {
            res += count[&ing];
        }

        res / target
    }
}
}