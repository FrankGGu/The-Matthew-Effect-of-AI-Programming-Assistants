var isLongPressedName = function(name, typed) {
    let i = 0, j = 0;
    while (i < name.length || j < typed.length) {
        if (name[i] !== typed[j]) {
            if (j > 0 && typed[j] === typed[j - 1]) {
                j++;
            } else {
                return false;
            }
        } else {
            i++;
            j++;
        }
    }
    return true;
};