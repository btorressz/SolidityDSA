// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract GoodStringsCounter {
    uint constant MOD = 1e9 + 7;

    function countGoodStrings(uint low, uint high, uint zero, uint one) public pure returns (uint count) {
        count = 0;
        for (uint length = low; length <= high; length++) {
            // Try to construct the length using `a * zero + b * one = length`
            for (uint a = 0; a * zero <= length; a++) {
                uint remainingLength = length - a * zero;
                if (remainingLength % one == 0) {
                    count = (count + 1) % MOD;
                }
            }
        }
        return count;
    }
}
