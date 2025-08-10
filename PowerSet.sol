/ SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract PowerSet {
    // Function to generate all possible subsets of the array
    function generateSubsets(int[] memory nums) public pure returns (int[][] memory) {
        uint n = nums.length;
        uint totalSubsets = 1 << n;  // 2^n subsets
        int[][] memory subsets = new int[][](totalSubsets);

        for (uint i = 0; i < totalSubsets; i++) {
            // Array to hold the subset corresponding to the bitmask i
            uint subsetSize = countBits(i);
            int[] memory subset = new int[](subsetSize);
            uint currentIndex = 0;

            for (uint j = 0; j < n; j++) {
                // Check if the j-th element is included in the i-th subset
                if ((i & (1 << j)) != 0) {
                    subset[currentIndex] = nums[j];
                    currentIndex++;
                }
            }
            subsets[i] = subset;
        }
        return subsets;
    }

    // Helper function to count the number of 1s in the binary representation of a number
    function countBits(uint num) private pure returns (uint count) {
        while (num > 0) {
            if (num & 1 == 1) count++;
            num = num >> 1;
        }
    }
}
