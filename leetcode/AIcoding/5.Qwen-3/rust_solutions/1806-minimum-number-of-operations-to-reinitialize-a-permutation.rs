impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn reinitialize_permutation(perm: Vec<i32>) -> i32 {
        let n = perm.len();
        let mut pos = vec![0; n];
        for i in 0..n {
            pos[perm[i] as usize] = i;
        }

        let mut res = 0;
        let mut current = 0;
        let mut seen = HashMap::new();

        while !seen.contains_key(&current) {
            seen.insert(current, res);
            res += 1;
            if current < n / 2 {
                current *= 2;
            } else {
                current = 2 * (current - n / 2) + 1;
            }
        }

        let start = seen[&current];
        let cycle_length = res - start;

        let mut result = 0;
        for i in 0..n {
            let mut current = i;
            let mut steps = 0;
            while current != 0 {
                if current < n / 2 {
                    current *= 2;
                } else {
                    current = 2 * (current - n / 2) + 1;
                }
                steps += 1;
            }
            result = std::cmp::max(result, steps);
        }

        result
    }
}
}