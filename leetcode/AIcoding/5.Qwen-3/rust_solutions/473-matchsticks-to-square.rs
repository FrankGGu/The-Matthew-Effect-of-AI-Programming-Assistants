impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn makesquare(mut matchsticks: Vec<i32>) -> bool {
        let sum: i32 = matchsticks.iter().sum();
        if sum % 4 != 0 {
            return false;
        }
        let target = sum / 4;
        matchsticks.sort_by(|a, b| b.cmp(a));

        let mut memo = HashMap::new();
        Self::dfs(&matchsticks, 0, 0, 0, 0, target, &mut memo)
    }

    fn dfs(
        matchsticks: &[i32],
        index: usize,
        side1: i32,
        side2: i32,
        side3: i32,
        target: i32,
        memo: &mut HashMap<(usize, i32, i32, i32), bool>,
    ) -> bool {
        if side1 == target && side2 == target && side3 == target {
            return true;
        }

        let key = (index, side1, side2, side3);
        if let Some(&result) = memo.get(&key) {
            return result;
        }

        for i in index..matchsticks.len() {
            let stick = matchsticks[i];
            if side1 + stick > target || side2 + stick > target || side3 + stick > target {
                continue;
            }

            let mut new_side1 = side1;
            let mut new_side2 = side2;
            let mut new_side3 = side3;

            if side1 + stick <= target {
                new_side1 += stick;
            } else if side2 + stick <= target {
                new_side2 += stick;
            } else if side3 + stick <= target {
                new_side3 += stick;
            } else {
                continue;
            }

            if Self::dfs(matchsticks, i + 1, new_side1, new_side2, new_side3, target, memo) {
                memo.insert(key, true);
                return true;
            }
        }

        memo.insert(key, false);
        false
    }
}
}