// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract MinSwaps {
    function minSwaps(int[] memory nums) public pure returns (int) {
        uint totalOnes = 0;
        uint n = nums.length;
        
        // Count the total number of 1's
        for (uint i = 0; i < n; i++) {
            if (nums[i] == 1) {
                totalOnes++;
            }
        }
        
        if (totalOnes <= 1) return 0;  // No need to swap if there is 0 or 1 '1's

        // Find the maximum number of 1's in any window of size totalOnes
        uint maxOnes = 0;
        uint currentOnes = 0;
        uint left = 0;
        
        // Initial window
        for (uint i = 0; i < totalOnes; i++) {
            if (nums[i] == 1) {
                currentOnes++;
            }
        }
        maxOnes = currentOnes;
        
        // Sliding window approach, circular array simulation by mod operation
        for (uint i = totalOnes; i < totalOnes + n - 1; i++) {
            if (nums[left] == 1) {
                currentOnes--;
            }
            if (nums[i % n] == 1) {
                currentOnes++;
            }
            maxOnes = max(maxOnes, currentOnes);
            left++;
        }
        
        // Minimum swaps is the number of 0's in the window of max 1's
        return int(totalOnes - maxOnes);
    }
    
    function max(uint a, uint b) private pure returns (uint) {
        return a > b ? a : b;
    }
}
