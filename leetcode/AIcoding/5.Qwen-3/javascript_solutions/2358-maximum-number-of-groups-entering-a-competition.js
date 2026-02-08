function maxNumberOfGroups(students) {
    let groups = 0;
    let i = 1;
    while (students >= i) {
        students -= i;
        groups++;
        i++;
    }
    return groups;
}