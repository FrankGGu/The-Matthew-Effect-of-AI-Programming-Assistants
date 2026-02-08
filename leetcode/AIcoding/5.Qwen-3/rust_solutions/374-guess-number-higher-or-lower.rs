struct Solution {}

impl Solution {
    pub fn guess_number(n: i32) -> i32 {
        let mut left = 1;
        let mut right = n;

        while left <= right {
            let mid = left + (right - left) / 2;
            let res = guess(mid);

            if res == 0 {
                return mid;
            } else if res == 1 {
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }

        -1
    }
}

fn guess(num: i32) -> i32 {
    // This function is provided by LeetCode and not part of the solution.
    // It returns -1 if the guess is higher than the target, 0 if equal, 1 if lower.
    unimplemented!()
}