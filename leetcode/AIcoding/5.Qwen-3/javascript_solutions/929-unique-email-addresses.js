var numUniqueEmails = function(emails) {
    const uniqueEmails = new Set();

    for (const email of emails) {
        let local = email.split('@')[0];
        let domain = email.split('@')[1];

        local = local.split('+')[0].replace(/\.+/g, '');

        uniqueEmails.add(local + '@' + domain);
    }

    return uniqueEmails.size;
};