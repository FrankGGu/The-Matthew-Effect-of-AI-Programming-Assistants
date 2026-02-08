struct NumArray {
    nums: Vec<i32>,
    tree: Vec<i32>,
}

impl NumArray {
    fn new(mut nums: Vec<i32>) -> Self {
        let n = nums.len();
        let mut tree = vec![0; n];
        for i in 0..n {
            Self::update_tree(&mut tree, i, nums[i]);
        }
        NumArray { nums, tree }
    }

    fn update_tree(tree: &mut Vec<i32>, index: usize, value: i32) {
        let mut i = index + 1;
        while i < tree.len() {
            tree[i] += value;
            i += i & -i as usize;
        }
    }

    fn query_tree(tree: &Vec<i32>, index: usize) -> i32 {
        let mut i = index + 1;
        let mut sum = 0;
        while i > 0 {
            sum += tree[i];
            i -= i & -i as usize;
        }
        sum
    }

    fn update(&mut self, index: i32, value: i32) {
        let idx = index as usize;
        let diff = value - self.nums[idx];
        self.nums[idx] = value;
        Self::update_tree(&mut self.tree, idx, diff);
    }

    fn sum_range(&self, left: i32, right: i32) -> i32 {
        Self::query_tree(&self.tree, right as usize) - Self::query_tree(&self.tree, left as usize - 1)
    }
}