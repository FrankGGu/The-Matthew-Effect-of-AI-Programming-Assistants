struct Solution;

impl Solution {
    pub fn beautiful_arrangement(i: i32, k: i32) -> Vec<i32> {
        let n = i as usize;
        let k = k as usize;
        let mut result = vec![0; n];
        let mut used = vec![false; n + 1];

        fn backtrack(
            index: usize,
            k: usize,
            n: usize,
            used: &mut Vec<bool>,
            result: &mut Vec<i32>,
        ) -> bool {
            if index == n {
                return true;
            }

            for num in 1..=n {
                if used[num] {
                    continue;
                }

                let mut count = 0;
                for i in 0..index {
                    if (result[i] - num).abs() == k {
                        count += 1;
                    }
                }

                if count < k {
                    used[num] = true;
                    result[index] = num;
                    if backtrack(index + 1, k, n, used, result) {
                        return true;
                    }
                    used[num] = false;
                }
            }

            false
        }

        backtrack(0, k, n, &mut used, &mut result);
        result
    }
}