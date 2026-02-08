mod solution {
    use std::collections::HashSet;

    pub fn min_operations(nums: Vec<i32>, nums_divide: Vec<i32>) -> i32 {
        fn gcd(a: i32, b: i32) -> i32 {
            if b == 0 { a } else { gcd(b, a % b) }
        }

        let mut nums = nums;
        nums.sort_unstable();

        let mut g = nums_divide[0];
        for &num in &nums_divide[1..] {
            g = gcd(g, num);
        }

        let mut seen = HashSet::new();
        for &num in &nums {
            if g % num == 0 {
                return seen.len() as i32;
            }
            seen.insert(num);
        }

        -1
    }
}