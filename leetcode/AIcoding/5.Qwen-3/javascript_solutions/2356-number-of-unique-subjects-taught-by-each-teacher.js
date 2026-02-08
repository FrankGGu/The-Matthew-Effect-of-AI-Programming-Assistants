function findTeachersSubjects(teachers) {
    const subjectMap = new Map();

    for (const [teacherId, subject] of teachers) {
        if (!subjectMap.has(teacherId)) {
            subjectMap.set(teacherId, new Set());
        }
        subjectMap.get(teacherId).add(subject);
    }

    const result = [];
    for (const [teacherId, subjects] of subjectMap) {
        result.push([teacherId, subjects.size]);
    }

    return result;
}