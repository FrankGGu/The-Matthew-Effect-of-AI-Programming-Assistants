impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn max_number_of_groups(mut skill: Vec<i32>) -> i32 {
        let mut freq = HashMap::new();
        for s in &skill {
            *freq.entry(*s).or_insert(0) += 1;
        }

        let mut groups = 0;
        let mut prev = 0;

        while let Some((&current, &count)) = freq.iter().next() {
            if current > prev {
                let min_count = count.min(prev + 1);
                groups += min_count;
                *freq.get_mut(&current).unwrap() -= min_count;
                if *freq.get_mut(&current).unwrap() == 0 {
                    freq.remove(&current);
                }
                prev += 1;
            } else {
                break;
            }
        }

        groups
    }
}
}