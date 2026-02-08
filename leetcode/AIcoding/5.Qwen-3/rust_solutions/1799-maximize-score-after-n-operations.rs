impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn max_score(nums: Vec<i32>) -> i32 {
        fn gcd(a: i32, b: i32) -> i32 {
            if b == 0 {
                a
            } else {
                gcd(b, a % b)
            }
        }

        fn dfs(nums: &Vec<i32>, visited: &mut Vec<bool>, memo: &mut HashMap<Vec<bool>, i32>) -> i32 {
            if let Some(&score) = memo.get(visited) {
                return score;
            }

            let mut max_score = 0;
            for i in 0..nums.len() {
                if !visited[i] {
                    for j in i + 1..nums.len() {
                        if !visited[j] {
                            visited[i] = true;
                            visited[j] = true;
                            let current_score = gcd(nums[i], nums[j]) * 2;
                            let next_score = dfs(nums, visited, memo);
                            max_score = max_score.max(current_score + next_score);
                            visited[i] = false;
                            visited[j] = false;
                        }
                    }
                }
            }

            memo.insert(visited.clone(), max_score);
            max_score
        }

        let n = nums.len();
        let mut visited = vec![false; n];
        let mut memo = HashMap::new();
        dfs(&nums, &mut visited, &mut memo)
    }
}
}