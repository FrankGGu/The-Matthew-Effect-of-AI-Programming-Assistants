function isIPv4(ip) {
    const parts = ip.split('.');
    if (parts.length !== 4) return false;
    for (let part of parts) {
        if (!/^\d+$/.test(part)) return false;
        if (part.length > 1 && part[0] === '0') return false;
        if (parseInt(part, 10) < 0 || parseInt(part, 10) > 255) return false;
    }
    return true;
}

function isIPv6(ip) {
    const parts = ip.split(':');
    if (parts.length !== 8) return false;
    const hexDigits = '0123456789abcdefABCDEF';
    for (let part of parts) {
        if (part.length < 1 || part.length > 4) return false;
        for (let c of part) {
            if (hexDigits.indexOf(c) === -1) return false;
        }
    }
    return true;
}

function invalidIPAddresses(input) {
    const lines = input.split('\n');
    const result = [];
    for (let line of lines) {
        if (line.trim() === '') continue;
        if (isIPv4(line.trim()) || isIPv6(line.trim())) {
            result.push('');
        } else {
            result.push(line.trim());
        }
    }
    return result.join('\n');
}