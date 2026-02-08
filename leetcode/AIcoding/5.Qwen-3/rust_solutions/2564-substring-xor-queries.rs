impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn substring_xor_queries(s: String) -> Vec<Vec<i32>> {
        let mut result = Vec::new();
        let mut map = HashMap::new();
        let n = s.len();

        for i in 0..n {
            let mut xor_val = 0;
            for j in i..n {
                xor_val ^= (s.as_bytes()[j] - b'0') as i32;
                let key = (i as i32, j as i32);
                map.insert(key, xor_val);
            }
        }

        for i in 0..n {
            for j in i..n {
                let key = (i as i32, j as i32);
                let val = map.get(&key).unwrap();
                result.push(vec![i as i32, j as i32, *val]);
            }
        }

        result
    }
}
}