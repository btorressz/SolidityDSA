// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CombinationSum {
    // Function to return the number of combinations that add up to the target
    function combinationSum(int[] memory nums, int target) public pure returns (uint) {
        uint[] memory dp = new uint[](uint(target + 1));
        dp[0] = 1;  // Base case: one way to make the target 0, using no elements

        for (uint i = 0; i < uint(nums.length); i++) {
            for (int j = 1; j <= target; j++) {
                if (j >= nums[i]) {
                    dp[uint(j)] += dp[uint(j - nums[i])];
                }
            }
        }

        //return dp[target];
        return dp[uint(target)];
    }
}
