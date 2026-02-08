struct Solution;

impl Solution {
    pub fn numberOfAlternatingGroups(nums: Vec<i32>, k: i32) -> i32 {
        let n = nums.len();
        let k = k as usize;
        let mut count = 0;

        for i in 0..n {
            let mut is_valid = true;
            for j in 0..k {
                let idx = (i + j) % n;
                if j > 0 && nums[idx] == nums[(i + j - 1) % n] {
                    is_valid = false;
                    break;
                }
            }
            if is_valid {
                count += 1;
            }
        }

        count
    }
}