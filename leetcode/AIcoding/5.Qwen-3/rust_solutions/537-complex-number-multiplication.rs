struct Solution;

impl Solution {
    pub fn complex_number_multiply(a: String, b: String) -> String {
        let parse_complex = |s: &str| {
            let parts: Vec<&str> = s.split(',').collect();
            let real = parts[0].parse::<i32>().unwrap();
            let imag = parts[1].strip_suffix("i").unwrap().parse::<i32>().unwrap();
            (real, imag)
        };

        let (a_real, a_imag) = parse_complex(&a);
        let (b_real, b_imag) = parse_complex(&b);

        let real = a_real * b_real - a_imag * b_imag;
        let imag = a_real * b_imag + a_imag * b_real;

        format!("{}+{}i", real, imag)
    }
}