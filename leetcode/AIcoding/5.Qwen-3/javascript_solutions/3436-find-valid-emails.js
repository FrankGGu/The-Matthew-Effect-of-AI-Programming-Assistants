function findValidEmails(text) {
    const emailRegex = /^[\w.-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
    const words = text.split(/\s+/);
    const validEmails = [];
    for (const word of words) {
        if (emailRegex.test(word)) {
            validEmails.push(word);
        }
    }
    return validEmails;
}