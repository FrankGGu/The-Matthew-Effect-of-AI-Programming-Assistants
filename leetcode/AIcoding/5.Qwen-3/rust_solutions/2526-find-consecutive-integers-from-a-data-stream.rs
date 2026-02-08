struct DataStream {
    nums: Vec<i32>,
    k: i32,
    key: i32,
}

impl DataStream {
    fn new(nums: Vec<i32>, k: i32, key: i32) -> Self {
        DataStream { nums, k, key }
    }

    fn consec(&self, num: i32) -> bool {
        let mut count = 0;
        for &n in &self.nums {
            if n == num {
                count += 1;
                if count >= self.k {
                    return true;
                }
            } else {
                count = 0;
            }
        }
        false
    }
}