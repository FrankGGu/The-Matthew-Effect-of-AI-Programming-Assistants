impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn max_score(scores: Vec<Vec<i32>>, students: Vec<Vec<i32>>, mentors: Vec<Vec<i32>>) -> i32 {
        fn score(a: &Vec<i32>, b: &Vec<i32>) -> i32 {
            a.iter().zip(b.iter()).map(|(&x, &y)| (x - y).abs()).sum()
        }

        fn backtrack(
            idx: usize,
            used: &mut Vec<bool>,
            scores: &Vec<Vec<i32>>,
            students: &Vec<Vec<i32>>,
            mentors: &Vec<Vec<i32>>,
            memo: &mut HashMap<usize, i32>,
        ) -> i32 {
            if idx == students.len() {
                return 0;
            }
            if let Some(&val) = memo.get(&idx) {
                return val;
            }

            let mut max_val = 0;
            for i in 0..students.len() {
                if !used[i] {
                    used[i] = true;
                    let curr = score(&students[idx], &mentors[i]);
                    let next = backtrack(idx + 1, used, scores, students, mentors, memo);
                    max_val = max_val.max(curr + next);
                    used[i] = false;
                }
            }
            memo.insert(idx, max_val);
            max_val
        }

        let mut used = vec![false; students.len()];
        let mut memo = HashMap::new();
        backtrack(0, &mut used, &scores, &students, &mentors, &mut memo)
    }
}
}