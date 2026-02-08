function findStudentsWhoImproved(students) {
    return students.filter(student => student.previousScore < student.currentScore);
}