function sortPeople(names, heights) {
    return names.map((name, index) => ({ name, height: heights[index] }))
        .sort((a, b) => b.height - a.height)
        .map(item => item.name);
}