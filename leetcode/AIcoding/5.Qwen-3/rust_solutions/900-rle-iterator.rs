struct RLEIterator {
    nums: Vec<i32>,
    index: usize,
}

impl RLEIterator {
    fn new(nums: Vec<i32>) -> Self {
        RLEIterator { nums, index: 0 }
    }

    fn next(&mut self, n: i32) -> i32 {
        let mut remaining = n;
        while self.index < self.nums.len() && remaining > 0 {
            let count = self.nums[self.index];
            let value = self.nums[self.index + 1];
            if count >= remaining {
                self.nums[self.index] -= remaining;
                return value;
            } else {
                remaining -= count;
                self.index += 2;
            }
        }
        -1
    }
}