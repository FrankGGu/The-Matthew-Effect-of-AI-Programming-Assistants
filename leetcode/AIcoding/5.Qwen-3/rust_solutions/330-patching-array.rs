impl Solution {
    pub fn min_patching_zeros(nums: Vec<i32>, n: i32) -> i32 {
        let mut res = 0;
        let mut miss = 1;
        let mut i = 0;
        while miss <= n {
            if i < nums.len() && nums[i] as i64 <= miss {
                miss += nums[i] as i64;
                i += 1;
            } else {
                miss += miss;
                res += 1;
            }
        }
        res
    }
}