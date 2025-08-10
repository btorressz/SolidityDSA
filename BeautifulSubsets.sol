// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BeautifulSubsets {
    // Function to count non-empty beautiful subsets
    function countBeautifulSubsets(uint[] memory nums, uint k) public pure returns (uint) {
        uint count = 0;
        uint n = nums.length;
        uint totalSubsets = 1 << n; // There are 2^n subsets

        // Iterate over each subset (except the empty subset)
        for (uint subset = 1; subset < totalSubsets; subset++) {
            bool isBeautiful = true;
            // Check pairs within the subset
            for (uint i = 0; i < n; i++) {
                for (uint j = i + 1; j < n; j++) {
                    // Both elements are in the subset
                    if (((subset & (1 << i)) != 0) && ((subset & (1 << j)) != 0)) {
                        // Check if the absolute difference is k
                        if (absoluteDifference(nums[i], nums[j]) == k) {
                            isBeautiful = false;
                            break;
                        }
                    }
                }
                if (!isBeautiful) break;
            }
            if (isBeautiful) {
                count++;
            }
        }
        return count;
    }

    // Helper function to compute the absolute difference
    function absoluteDifference(uint a, uint b) private pure returns (uint) {
        return a > b ? a - b : b - a;
    }
}
