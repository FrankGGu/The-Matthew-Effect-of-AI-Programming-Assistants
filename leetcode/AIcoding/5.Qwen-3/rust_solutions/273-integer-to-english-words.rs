struct Solution;

impl Solution {
    pub fn number_to_words(mut num: i32) -> String {
        if num == 0 {
            return "Zero".to_string();
        }

        let units = ["", "One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine"];
        let teens = ["Ten", "Eleven", "Twelve", "Thirteen", "Fourteen", "Fifteen", "Sixteen", "Seventeen", "Eighteen", "Nineteen"];
        let tens = ["", "Ten", "Twenty", "Thirty", "Forty", "Fifty", "Sixty", "Seventy", "Eighty", "Ninety"];
        let thousands = ["", "Thousand", "Million", "Billion"];

        let mut result = String::new();
        let mut i = 0;

        while num > 0 {
            let chunk = num % 1000;
            num /= 1000;

            if chunk > 0 {
                let mut chunk_str = String::new();

                if chunk / 100 > 0 {
                    chunk_str.push_str(units[chunk / 100]);
                    chunk_str.push_str(" Hundred");
                }

                let remainder = chunk % 100;
                if remainder > 0 {
                    if chunk_str.len() > 0 {
                        chunk_str.push(' ');
                    }

                    if remainder < 10 {
                        chunk_str.push_str(units[remainder]);
                    } else if remainder < 20 {
                        chunk_str.push_str(teens[remainder - 10]);
                    } else {
                        chunk_str.push_str(tens[remainder / 10]);
                        if remainder % 10 > 0 {
                            chunk_str.push(' ');
                            chunk_str.push_str(units[remainder % 10]);
                        }
                    }
                }

                if i > 0 {
                    chunk_str.push(' ');
                    chunk_str.push_str(thousands[i]);
                }

                if result.len() > 0 {
                    chunk_str.push(' ');
                }

                result = chunk_str + &result;
            }

            i += 1;
        }

        result
    }
}