function subdomainVisits(cpdomains) {
    const countMap = new Map();

    for (const domain of cpdomains) {
        const [countStr, fullDomain] = domain.split(' ');
        const count = parseInt(countStr, 10);
        const domains = fullDomain.split('.');

        for (let i = 0; i < domains.length; i++) {
            const subDomain = domains.slice(i).join('.');
            countMap.set(subDomain, (countMap.get(subDomain) || 0) + count);
        }
    }

    const result = [];
    for (const [domain, count] of countMap.entries()) {
        result.push(`${count} ${domain}`);
    }

    return result;
}