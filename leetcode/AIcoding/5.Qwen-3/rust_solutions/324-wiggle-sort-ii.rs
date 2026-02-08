struct Solution;

impl Solution {
    pub fn wiggle_sort(nums: &mut Vec<i32>) {
        let n = nums.len();
        if n <= 1 {
            return;
        }
        let mut temp = nums.clone();
        temp.sort();
        let mut i = 1;
        let mut j = n - 1;
        while i < n {
            nums[i] = temp[j];
            j -= 1;
            i += 2;
        }
        i = 0;
        j = n - 1;
        while i < n {
            nums[i] = temp[j];
            j -= 1;
            i += 2;
        }
    }
}