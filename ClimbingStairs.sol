// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ClimbingStairs {
    // Function to calculate the number of distinct ways to climb to the top of the staircase
    function climbStairs(uint n) public pure returns (uint) {
        if (n == 1) {
            return 1;
        }
        if (n == 2) {
            return 2;
        }

        uint oneStepBefore = 2; // This represents the number of ways to reach the (n-1)th step
        uint twoStepsBefore = 1; // This represents the number of ways to reach the (n-2)th step
        uint current = 0;

        for (uint i = 3; i <= n; i++) {
            current = oneStepBefore + twoStepsBefore;
            twoStepsBefore = oneStepBefore;
            oneStepBefore = current;
        }

        return current;
    }
}
