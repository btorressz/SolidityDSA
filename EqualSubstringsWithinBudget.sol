// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract EqualSubstringsWithinBudget {
    function maxEqualSubstring(string memory s, string memory t, uint maxCost) public pure returns (uint) {
        bytes memory bs = bytes(s);
        bytes memory bt = bytes(t);
        uint n = bs.length;

        uint[] memory costs = new uint[](n);
        for (uint i = 0; i < n; i++) {
            costs[i] = uint(abs(int(bs[i]) - int(bt[i])));
        }

        uint maxLen = 0;
        uint start = 0;
        uint currentCost = 0;

        for (uint end = 0; end < n; end++) {
            currentCost += costs[end];

            while (currentCost > maxCost) {
                currentCost -= costs[start];
                start++;
            }

            if (end - start + 1 > maxLen) {
                maxLen = end - start + 1;
            }
        }

        return maxLen;
    }

    function abs(int x) private pure returns (int) {
        return x < 0 ? -x : x;
    }
}
