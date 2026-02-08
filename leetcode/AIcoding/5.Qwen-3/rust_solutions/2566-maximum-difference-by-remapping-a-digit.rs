struct Solution;

impl Solution {
    pub fn max_diff(num: i32) -> i32 {
        let s = num.to_string();
        let mut min_num = num;
        let mut max_num = num;

        for i in 0..s.len() {
            let c = s.chars().nth(i).unwrap();
            if c != '9' {
                let mut temp = s.clone();
                for j in i..temp.len() {
                    if temp.chars().nth(j).unwrap() == c {
                        temp = temp[..j].to_string() + "9" + &temp[j+1..];
                    }
                }
                max_num = max_num.max(temp.parse().unwrap());
                break;
            }
        }

        for i in 0..s.len() {
            let c = s.chars().nth(i).unwrap();
            if c != '0' {
                let mut temp = s.clone();
                for j in i..temp.len() {
                    if temp.chars().nth(j).unwrap() == c {
                        temp = temp[..j].to_string() + "0" + &temp[j+1..];
                    }
                }
                min_num = min_num.min(temp.parse().unwrap());
                break;
            }
        }

        max_num - min_num
    }
}