impl Solution {

use std::collections::HashMap;

struct Solution {}

impl Solution {
    pub fn find_even_numbers(digits: Vec<i32>) -> Vec<i32> {
        let mut result = Vec::new();
        let mut count = HashMap::new();

        for &d in &digits {
            *count.entry(d).or_insert(0) += 1;
        }

        for i in 0..1000 {
            let hundreds = i / 100;
            let tens = (i / 10) % 10;
            let units = i % 10;

            if hundreds == 0 {
                continue;
            }

            let mut temp_count = count.clone();
            let mut valid = true;

            for &d in &[hundreds, tens, units] {
                if *temp_count.get(&d).unwrap() == 0 {
                    valid = false;
                    break;
                }
                *temp_count.get_mut(&d).unwrap() -= 1;
            }

            if valid {
                result.push(i);
            }
        }

        result
    }
}
}