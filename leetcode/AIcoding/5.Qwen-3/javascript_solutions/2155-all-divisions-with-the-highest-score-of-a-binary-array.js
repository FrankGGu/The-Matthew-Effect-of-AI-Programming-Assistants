function maxScoreIndices(binaryArray) {
    let zeroCount = 0;
    let oneCount = 0;
    for (let num of binaryArray) {
        if (num === 0) zeroCount++;
        else oneCount++;
    }

    let maxScore = 0;
    let result = [];

    for (let i = 0; i <= binaryArray.length; i++) {
        let leftZero = i === 0 ? 0 : (binaryArray[i - 1] === 0 ? zeroCount-- : zeroCount);
        let leftOne = i === 0 ? 0 : (binaryArray[i - 1] === 1 ? oneCount-- : oneCount);
        let score = leftZero + (oneCount - leftOne);

        if (score > maxScore) {
            maxScore = score;
            result = [i];
        } else if (score === maxScore) {
            result.push(i);
        }
    }

    return result;
}