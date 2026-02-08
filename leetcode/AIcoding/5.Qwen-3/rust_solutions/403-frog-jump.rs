impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn can_cross(stones: Vec<i32>) -> bool {
        if stones[0] != 0 {
            return false;
        }
        let mut map = std::collections::HashMap::new();
        for (i, &stone) in stones.iter().enumerate() {
            map.entry(stone).or_insert_with(HashSet::new).insert(i);
        }
        let mut dp = std::collections::HashMap::new();
        dp.insert(0, HashSet::new());
        dp.get_mut(&0).unwrap().insert(0);
        for (i, &stone) in stones.iter().enumerate() {
            if !dp.contains_key(&stone) {
                continue;
            }
            for &jump in dp.get(&stone).unwrap() {
                for j in [jump - 1, jump, jump + 1] {
                    if j > 0 {
                        let next_stone = stone + j;
                        if let Some(indices) = map.get(&next_stone) {
                            for &idx in indices {
                                if idx > i {
                                    dp.entry(next_stone).or_insert_with(HashSet::new).insert(j);
                                }
                            }
                        }
                    }
                }
            }
        }
        for (_, jumps) in dp {
            if jumps.contains(&0) {
                return true;
            }
        }
        false
    }
}
}