// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MaxSumTree {
    // Function to compute the maximum achievable sum after any number of XOR operations
    function maxSumAfterXor(uint[] memory nums, uint k, uint[][] memory edges) public pure returns (uint) {
        uint n = nums.length;
        uint maxSum = 0;
        bool[] memory toggled = new bool[](n); // To track if XOR operation is applied

        // Initial sum calculation
        for (uint i = 0; i < n; i++) {
            maxSum += nums[i];
        }

        // Check each node if toggling it with k gives a higher sum
        uint potentialNewSum;
        for (uint i = 0; i < n; i++) {
            potentialNewSum = maxSum - nums[i] + (nums[i] ^ k); // Calculate new sum if toggled

            if (potentialNewSum > maxSum) {
                // Apply XOR and update sum if it results in a higher total
                nums[i] ^= k;
                maxSum = potentialNewSum;
                toggled[i] = true; // Mark this node as toggled
            }
        }

        // Return the maximum sum achieved
        return maxSum;
    }
}

/* Warning: Unused function parameter. Remove or comment out the variable name to silence this warning.
--> contracts/MaxSumTree.sol:6:57:
|
6 | function maxSumAfterXor(uint[] memory nums, uint k, uint[][] memory edges) public pure returns (uint) {
| ^^^^^^^^^^^^^^^^^^^^^
 */