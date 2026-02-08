function sortArrayByParity(A) {
    return A.sort((a, b) => (a % 2 === 0 ? -1 : 1));
}