// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DailyTemperatures {
    function dailyTemperatures(uint[] memory temperatures) public pure returns (uint[] memory) {
        uint n = temperatures.length;
        uint[] memory ans = new uint[](n);
        uint[] memory stack = new uint[](n); // Stack to store indices
        uint top = 0; // This will also act as the size of the stack

        for (uint i = 0; i < n; i++) {
            while (top > 0 && temperatures[i] > temperatures[stack[top - 1]]) {
                uint idx = stack[top - 1];
                ans[idx] = i - idx;
                top--; // Pop the stack
            }
            stack[top++] = i; // Push current index onto the stack
        }

        return ans;
    }
}
