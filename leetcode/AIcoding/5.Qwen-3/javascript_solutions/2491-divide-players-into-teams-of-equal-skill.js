function dividePlayersIntoTeamsOfEqualSkill(skills) {
    skills.sort((a, b) => a - b);
    let total = 0;
    for (let i = 0; i < skills.length / 2; i++) {
        if (skills[i] + skills[skills.length - 1 - i] !== skills[0] + skills[skills.length - 1]) {
            return -1;
        }
        total += skills[i] * skills[skills.length - 1 - i];
    }
    return total;
}