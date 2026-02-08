struct Solution;

impl Solution {
    pub fn shortest_beautiful_string(n: i32, k: i32) -> String {
        let mut res = vec![];
        let mut count = vec![0; 26];
        let mut used = vec![false; 26];

        fn backtrack(
            n: i32,
            k: i32,
            count: &mut Vec<i32>,
            used: &mut Vec<bool>,
            res: &mut Vec<char>,
            start: i32,
        ) -> bool {
            if res.len() as i32 == n {
                return true;
            }

            for c in start..26 {
                if used[c as usize] || count[c as usize] >= k {
                    continue;
                }

                let ch = (b'a' + c as u8) as char;
                res.push(ch);
                used[c as usize] = true;
                count[c as usize] += 1;

                if backtrack(n, k, count, used, res, c + 1) {
                    return true;
                }

                res.pop();
                used[c as usize] = false;
                count[c as usize] -= 1;
            }

            false
        }

        backtrack(n, k, &mut count, &mut used, &mut res, 0);
        res.into_iter().collect()
    }
}