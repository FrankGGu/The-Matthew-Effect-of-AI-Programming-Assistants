struct Solution;

impl Solution {
    pub fn closest_divisors(num: i32) -> Vec<i32> {
        fn find_closest(n: i32) -> Vec<i32> {
            let mut sqrt_n = (n as f64).sqrt() as i32;
            while sqrt_n > 0 {
                if n % sqrt_n == 0 {
                    return vec![sqrt_n, n / sqrt_n];
                }
                sqrt_n -= 1;
            }
            vec![1, 1]
        }

        let mut res = vec![1, 1];
        for i in num..(num + 2) {
            let current = find_closest(i);
            if current[1] - current[0] < res[1] - res[0] {
                res = current;
            }
        }
        res
    }
}