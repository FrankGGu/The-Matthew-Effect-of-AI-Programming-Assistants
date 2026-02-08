function topStudents(messages, senders, k) {
    const count = {};
    for (let i = 0; i < messages.length; i++) {
        const message = messages[i];
        const sender = senders[i];
        const words = message.split(' ').length;
        count[sender] = (count[sender] || 0) + words;
    }

    const sorted = Object.entries(count).sort((a, b) => {
        if (b[1] !== a[1]) return b[1] - a[1];
        return a[0].localeCompare(b[0]);
    });

    return sorted.slice(0, k).map(item => item[0]);
}