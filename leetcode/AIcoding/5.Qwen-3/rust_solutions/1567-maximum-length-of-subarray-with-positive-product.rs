pub fn max_len_subarray_with_positive_product(nums: Vec<i32>) -> i32 {
    let mut max_len = 0;
    let mut positive = 0;
    let mut negative = 0;

    for num in nums {
        if num == 0 {
            positive = 0;
            negative = 0;
        } else if num > 0 {
            positive += 1;
            negative = if negative != 0 { negative + 1 } else { 0 };
        } else {
            let temp = positive;
            positive = if negative != 0 { negative + 1 } else { 0 };
            negative = temp + 1;
        }

        max_len = max_len.max(positive);
    }

    max_len
}