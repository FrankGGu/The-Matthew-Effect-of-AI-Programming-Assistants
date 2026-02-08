struct Solution;

impl Solution {
    pub fn num_teams(rating: Vec<i32>) -> i32 {
        let n = rating.len();
        let mut teams = 0;

        for i in 0..n {
            let mut left_less = 0;
            let mut left_more = 0;
            let mut right_less = 0;
            let mut right_more = 0;

            for j in 0..i {
                if rating[j] < rating[i] {
                    left_less += 1;
                } else if rating[j] > rating[i] {
                    left_more += 1;
                }
            }

            for j in (i + 1)..n {
                if rating[j] < rating[i] {
                    right_less += 1;
                } else if rating[j] > rating[i] {
                    right_more += 1;
                }
            }

            teams += left_less * right_more;
            teams += left_more * right_less;
        }

        teams
    }
}