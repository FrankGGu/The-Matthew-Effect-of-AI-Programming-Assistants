impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn find_original_string(encoded: String) -> String {
        let n = encoded.len();
        let mut freq = HashMap::new();
        for c in encoded.chars() {
            *freq.entry(c).or_insert(0) += 1;
        }

        let mut result = Vec::new();
        let mut used = vec![false; n];

        for i in 0..n {
            if !used[i] {
                let mut count = 0;
                let mut j = i;
                while j < n {
                    if !used[j] {
                        count += 1;
                        used[j] = true;
                    }
                    j += count;
                }
                let c = encoded.chars().nth(i).unwrap();
                result.push(c);
            }
        }

        result.into_iter().collect()
    }
}
}