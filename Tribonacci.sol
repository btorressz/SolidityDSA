// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Tribonacci {
    function tribonacci(uint n) public pure returns (uint) {
        if (n == 0) return 0;
        if (n == 1 || n == 2) return 1;

        uint prev3 = 0; // T0
        uint prev2 = 1; // T1
        uint prev1 = 1; // T2
        uint current;

        for (uint i = 3; i <= n; i++) {
            current = prev3 + prev2 + prev1;
            prev3 = prev2;
            prev2 = prev1;
            prev1 = current;
        }

        return current;
    }
}
