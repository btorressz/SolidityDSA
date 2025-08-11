// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SumOfSquareNumbers {
    // Function to determine if there are two integers a and b such that a^2 + b^2 = c
    function judgeSquareSum(uint c) public pure returns (bool) {
        for (uint a = 0; a * a <= c; a++) {
            uint bSquared = c - a * a;
            if (isPerfectSquare(bSquared)) {
                return true;
            }
        }
        return false;
    }

    // Helper function to check if a number is a perfect square
    function isPerfectSquare(uint x) internal pure returns (bool) {
        uint left = 0;
        uint right = x;
        while (left <= right) {
            uint mid = left + (right - left) / 2;
            uint midSquared = mid * mid;
            if (midSquared == x) {
                return true;
            } else if (midSquared < x) {
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }
        return false;
    }
}
