impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn longest_awesome(s: String) -> i32 {
        let mut map = HashMap::new();
        map.insert(0, -1);
        let mut res = 0;
        let mut mask = 0;
        for (i, c) in s.chars().enumerate() {
            let idx = c as usize - '0' as usize;
            mask ^= 1 << idx;
            if let Some(&pos) = map.get(&mask) {
                res = res.max(i as i32 - pos);
            } else {
                map.insert(mask, i as i32);
            }
            for j in 0..10 {
                let tmp_mask = mask ^ (1 << j);
                if let Some(&pos) = map.get(&tmp_mask) {
                    res = res.max(i as i32 - pos);
                }
            }
        }
        res
    }
}
}