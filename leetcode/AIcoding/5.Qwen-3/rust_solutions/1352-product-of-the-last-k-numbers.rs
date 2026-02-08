struct ProductOfNumbers {
    nums: Vec<i32>,
}

impl ProductOfNumbers {
    fn new() -> Self {
        ProductOfNumbers { nums: vec![] }
    }

    fn add(&mut self, num: i32) {
        self.nums.push(num);
    }

    fn get_product(&self, k: i32) -> i32 {
        let k = k as usize;
        let mut product = 1;
        for i in (self.nums.len() - k)..self.nums.len() {
            product *= self.nums[i];
        }
        product
    }
}