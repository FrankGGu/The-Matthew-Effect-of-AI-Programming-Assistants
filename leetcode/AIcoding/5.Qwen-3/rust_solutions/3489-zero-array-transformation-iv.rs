struct Solution;

impl Solution {
    pub fn is_possible(target: Vec<i32>) -> bool {
        let mut target = target;
        target.sort();
        let mut total = target.iter().sum::<i32>();
        for i in (0..target.len() - 1).rev() {
            if target[i] == target[i + 1] {
                continue;
            }
            let diff = target[i] - target[i + 1];
            if diff % (i as i32 + 1) != 0 {
                return false;
            }
            total -= diff;
            target[i] = target[i + 1];
        }
        total == 0
    }
}