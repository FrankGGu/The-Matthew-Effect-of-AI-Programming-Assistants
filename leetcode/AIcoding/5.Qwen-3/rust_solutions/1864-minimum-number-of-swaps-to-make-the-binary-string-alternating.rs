impl Solution {
    pub fn min_swaps(s: String) -> i32 {
        let (mut even_ones, mut odd_ones) = (0, 0);
        for (i, c) in s.chars().enumerate() {
            if c == '1' {
                if i % 2 == 0 {
                    even_ones += 1;
                } else {
                    odd_ones += 1;
                }
            }
        }

        if even_ones == odd_ones {
            return 0;
        }

        if even_ones > odd_ones {
            (even_ones - odd_ones) as i32
        } else {
            (odd_ones - even_ones) as i32
        }
    }
}