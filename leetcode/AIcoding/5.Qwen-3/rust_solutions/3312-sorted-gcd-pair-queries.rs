impl Solution {

use std::cmp::Ordering;
use std::collections::HashMap;

struct Solution {}

impl Solution {
    pub fn sorted_gcd_pairs(mut nums: Vec<i32>, queries: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
        let n = nums.len();
        let mut gcd_map: HashMap<i32, Vec<Vec<i32>>> = HashMap::new();

        for i in 0..n {
            for j in i + 1..n {
                let g = Self::gcd(nums[i], nums[j]);
                let key = g;
                let pair = vec![nums[i], nums[j]];
                gcd_map.entry(key).or_insert_with(Vec::new).push(pair);
            }
        }

        for (_, pairs) in &mut gcd_map {
            pairs.sort();
        }

        let mut sorted_keys: Vec<i32> = gcd_map.keys().cloned().collect();
        sorted_keys.sort();

        let mut result = Vec::new();
        for q in queries {
            let k = q[0];
            let m = q[1] as usize;
            let pairs = gcd_map.get(&k).unwrap_or(&vec![]);
            let mut res = vec![];
            for i in 0..std::cmp::min(m, pairs.len()) {
                res.push(pairs[i][0]);
                res.push(pairs[i][1]);
            }
            result.push(res);
        }

        result
    }

    fn gcd(a: i32, b: i32) -> i32 {
        if b == 0 {
            a
        } else {
            Self::gcd(b, a % b)
        }
    }
}
}