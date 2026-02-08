struct Solution {}

impl Solution {
    pub fn max_chunks_to_sorted(arr: Vec<i32>) -> i32 {
        let mut max_so_far = 0;
        let mut chunks = 0;
        for (i, &val) in arr.iter().enumerate() {
            max_so_far = std::cmp::max(max_so_far, val);
            if max_so_far == i as i32 {
                chunks += 1;
            }
        }
        chunks
    }
}