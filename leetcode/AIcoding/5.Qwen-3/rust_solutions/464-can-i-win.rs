impl Solution {

use std::collections::HashMap;

struct Solution;

impl Solution {
    pub fn can_i_win(need: i32, max_round: i32) -> bool {
        fn dfs(used: i32, need: i32, memo: &mut HashMap<i32, bool>) -> bool {
            if let Some(&result) = memo.get(&used) {
                return result;
            }
            for i in 1..=max_round {
                if (used & (1 << i)) == 0 {
                    if need - i <= 0 {
                        memo.insert(used, true);
                        return true;
                    }
                    if !dfs(used | (1 << i), need - i, memo) {
                        memo.insert(used, true);
                        return true;
                    }
                }
            }
            memo.insert(used, false);
            false
        }

        let total = (1..=max_round).sum::<i32>();
        if total < need {
            return false;
        }
        dfs(0, need, &mut HashMap::new())
    }
}
}