impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn num_rabbits(mut answers: Vec<i32>) -> i32 {
        let mut count = HashMap::new();
        let mut result = 0;

        for ans in answers {
            let key = ans;
            let val = count.entry(key).or_insert(0);
            *val += 1;

            if *val == key + 1 {
                result += key + 1;
                count.remove(&key);
            }
        }

        result
    }
}
}