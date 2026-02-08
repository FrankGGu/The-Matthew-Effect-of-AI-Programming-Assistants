pub fn average_salary_employees(salary: Vec<i32>) -> f64 {
    let min = salary.iter().min().copied().unwrap();
    let max = salary.iter().max().copied().unwrap();
    let sum: i32 = salary.iter().filter(|&&s| s != min && s != max).sum();
    let count = salary.len() as i32 - 2;
    sum as f64 / count as f64
}