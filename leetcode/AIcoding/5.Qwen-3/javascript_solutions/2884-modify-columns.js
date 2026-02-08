function modifyColumns(employees) {
    return employees.map(emp => ({
        employee_id: emp.employee_id,
        name: emp.name,
        salary: emp.salary * 10
    }));
}