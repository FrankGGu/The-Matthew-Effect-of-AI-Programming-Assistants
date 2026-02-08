class Solution:
    def invalidIPAddresses(self, addresses):
        def is_valid_ipv4(ip):
            parts = ip.split('.')
            if len(parts) != 4:
                return False
            for part in parts:
                if not part.isdigit():
                    return False
                num = int(part)
                if num < 0 or num > 255:
                    return False
                if len(part) > 1 and part[0] == '0':
                    return False
            return True

        def is_valid_ipv6(ip):
            parts = ip.split(':')
            if len(parts) != 8:
                return False
            hex_chars = set("0123456789abcdefABCDEF")
            for part in parts:
                if len(part) < 1 or len(part) > 4:
                    return False
                for c in part:
                    if c not in hex_chars:
                        return False
            return True

        result = []
        for address in addresses:
            if not is_valid_ipv4(address) and not is_valid_ipv6(address):
                result.append(address)
        return result