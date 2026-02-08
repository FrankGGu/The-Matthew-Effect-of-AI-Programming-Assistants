from collections import defaultdict
from typing import List

class Solution:
    def subdomainVisits(self, cpdomains: List[str]) -> List[str]:
        count = defaultdict(int)
        for domain in cpdomains:
            parts = domain.split()
            num = int(parts[0])
            full_domain = parts[1]
            sub_domains = []
            while '.' in full_domain:
                sub_domains.append(full_domain)
                full_domain = full_domain[full_domain.index('.') + 1:]
            sub_domains.append(full_domain)
            for sub in sub_domains:
                count[sub] += num
        return [f"{v} {k}" for k, v in count.items()]