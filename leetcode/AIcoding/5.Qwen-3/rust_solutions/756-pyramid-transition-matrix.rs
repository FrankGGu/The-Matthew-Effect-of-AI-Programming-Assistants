impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn pyramid_transition_matrix(bottom: String, allowed: Vec<Vec<char>>) -> bool {
        let mut map = HashMap::new();
        for pair in allowed {
            let key = (pair[0], pair[1]);
            map.entry(key).or_insert_with(Vec::new).push(pair[2]);
        }

        let mut dp = HashMap::new();
        for c in bottom.chars() {
            dp.insert(c, 1);
        }

        let mut next_dp = HashMap::new();
        for i in 0..bottom.len() - 1 {
            let c1 = bottom.chars().nth(i).unwrap();
            let c2 = bottom.chars().nth(i + 1).unwrap();
            if let Some(chars) = map.get(&(c1, c2)) {
                for &c in chars {
                    *next_dp.entry(c).or_insert(0) += 1;
                }
            }
        }

        if next_dp.is_empty() {
            return false;
        }

        let mut current = next_dp;
        while current.len() > 1 {
            let mut next = HashMap::new();
            for (i, c1) in current.iter().enumerate() {
                for j in i + 1..current.len() {
                    let c2 = current.keys().nth(j).unwrap();
                    if let Some(chars) = map.get(&(c1.0, c2.0)) {
                        for &c in chars {
                            *next.entry(c).or_insert(0) += 1;
                        }
                    }
                }
            }

            if next.is_empty() {
                return false;
            }

            current = next;
        }

        true
    }
}
}