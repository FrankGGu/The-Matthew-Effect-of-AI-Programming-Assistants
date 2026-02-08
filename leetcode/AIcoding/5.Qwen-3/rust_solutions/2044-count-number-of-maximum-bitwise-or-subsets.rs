impl Solution {
    pub fn count_max_or_subsets(nums: Vec<i32>) -> i32 {
        let mut max_or = 0;
        let n = nums.len();

        for i in 0..n {
            max_or |= nums[i];
        }

        let mut count = 0;

        for mask in 1..(1 << n) {
            let mut current_or = 0;
            for i in 0..n {
                if (mask >> i) & 1 == 1 {
                    current_or |= nums[i];
                }
            }
            if current_or == max_or {
                count += 1;
            }
        }

        count
    }
}