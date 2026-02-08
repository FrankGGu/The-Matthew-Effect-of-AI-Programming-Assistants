struct Solution {}

impl Solution {
    pub fn single_number(nums: Vec<i32>) -> i32 {
        let mut ones = 0;
        let mut twos = 0;
        let mut threes = 0;

        for num in nums {
            twos |= ones & num;
            ones ^= num;
            threes = ones & twos;
            ones &= !threes;
            twos &= !threes;
        }

        ones
    }
}