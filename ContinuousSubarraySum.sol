// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ContinuousSubarraySum {
    function hasSubarrayMultipleOfK(int[] memory nums, int k) public pure returns (bool) {
        if (k == 0) return false; // Edge case handling
        uint n = nums.length;
        mapping(int => uint) prefixModIndex;
        
        int cumulativeSum = 0;
        int modValue;
        
        // Initialize the mapping with the mod result of 0 starting at index -1 (before the start of the array)
        prefixModIndex[0] = uint(-1);
        
        for (uint i = 0; i < n; ++i) {
            cumulativeSum += nums[i];
            
            // Taking mod with k and handling negative values
            modValue = int(uint(cumulativeSum) % uint(k));
            if (modValue < 0) {
                modValue += k;
            }
            
            if (prefixModIndex[modValue] == 0 && modValue != 0) {
                // New mod value that is not the initial 0 (from index -1 initialization)
                prefixModIndex[modValue] = i + 1;
            } else {
                // Check the length condition
                if (i > prefixModIndex[modValue]) return true;
            }
        }
        return false;
    }
}
