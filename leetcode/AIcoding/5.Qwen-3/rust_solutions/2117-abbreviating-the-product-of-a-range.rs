struct Solution;

impl Solution {
    pub fn abbreviate_product(mut left: i32, mut right: i32) -> String {
        let mut numerator = 1;
        let mut denominator = 1;
        let mut count_5 = 0;
        let mut count_2 = 0;
        let mut power = 0;

        while left <= right {
            let mut n = left;
            while n % 5 == 0 {
                count_5 += 1;
                n /= 5;
            }
            while n % 2 == 0 {
                count_2 += 1;
                n /= 2;
            }
            if n != 1 {
                numerator *= n;
                if numerator > 100000000 {
                    denominator *= 100000000;
                    numerator /= 100000000;
                }
            }
            left += 1;
        }

        let mut exp = count_5.min(count_2);
        count_2 -= exp;
        count_5 -= exp;

        let mut result = String::new();
        let mut temp = numerator / denominator;
        let mut digits = 0;

        while temp > 0 {
            digits += 1;
            temp /= 10;
        }

        let mut suffix = String::new();
        let mut temp = numerator / denominator;
        for _ in 0..min(5, digits) {
            suffix.insert(0, (temp % 10) as u8 as char);
            temp /= 10;
        }

        if digits > 5 {
            result.push_str(&suffix);
            result.push('*');
            result.push_str(&format!("10^{}", count_2 + count_5).as_str());
        } else {
            result.push_str(&format!("{}*10^{}", temp, count_2 + count_5).as_str());
        }

        result
    }
}