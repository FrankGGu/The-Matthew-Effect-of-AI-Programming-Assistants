struct Solution;

impl Solution {
    pub fn k_items_with_maximum_sum(mut k: i32, mut put_left: i32, mut put_right: i32, mut remove_left: i32, mut remove_right: i32) -> i32 {
        let mut total = 0;

        while k > 0 {
            let mut max_val = 0;

            if put_left > 0 {
                max_val = std::cmp::max(max_val, 1);
            }
            if put_right > 0 {
                max_val = std::cmp::max(max_val, 1);
            }
            if remove_left > 0 {
                max_val = std::cmp::max(max_val, -1);
            }
            if remove_right > 0 {
                max_val = std::cmp::max(max_val, -1);
            }

            if max_val == 1 {
                total += 1;
                if put_left > 0 {
                    put_left -= 1;
                } else {
                    put_right -= 1;
                }
            } else if max_val == -1 {
                total -= 1;
                if remove_left > 0 {
                    remove_left -= 1;
                } else {
                    remove_right -= 1;
                }
            }

            k -= 1;
        }

        total
    }
}