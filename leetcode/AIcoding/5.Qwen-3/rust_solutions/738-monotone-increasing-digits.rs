struct Solution;

impl Solution {
    pub fn monotone_increasing_digits(mut n: i32) -> i32 {
        let mut digits = Vec::new();
        let mut num = n;
        while num > 0 {
            digits.push(num % 10);
            num /= 10;
        }
        digits.reverse();

        let mut i = 0;
        while i < digits.len() - 1 {
            if digits[i] > digits[i + 1] {
                break;
            }
            i += 1;
        }

        if i == digits.len() - 1 {
            return n;
        }

        while i >= 0 && digits[i] == digits[i + 1] {
            i -= 1;
        }

        let mut result = 0;
        for j in 0..i {
            result = result * 10 + digits[j];
        }

        result = result * 10 + digits[i] - 1;

        for _ in i + 1..digits.len() {
            result = result * 10;
        }

        result
    }
}