// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MaximumSubsequenceScore {
    // Function to return the maximum possible score
    function maxScore(int[] memory nums1, int[] memory nums2, uint k) public pure returns (int) {
        uint n = nums1.length;
        require(n == nums2.length && k <= n, "Invalid input sizes or k value.");

        // Create pairs and sort by nums2 in descending order to maximize the minimum value
        Pair[] memory pairs = new Pair[](n);
        for (uint i = 0; i < n; i++) {
            pairs[i] = Pair(nums1[i], nums2[i]);
        }
        // Sort pairs based on nums2 values using a simple insertion sort for demonstration purposes
        for (uint i = 1; i < n; i++) {
            Pair memory key = pairs[i];
            int j = int(i) - 1;
            while (j >= 0 && pairs[uint(j)].nums2 < key.nums2) {
                pairs[uint(j + 1)] = pairs[uint(j)];
                j--;
            }
            pairs[uint(j + 1)] = key;
        }

        // Select the top k elements with the largest nums2 values and calculate the sum and minimum
        int sum = 0;
        int minimum = int(1e9 + 7); // Arbitrarily large number for comparison
        for (uint i = 0; i < k; i++) {
            sum += pairs[i].nums1;
            if (pairs[i].nums2 < minimum) {
                minimum = pairs[i].nums2;
            }
        }

        return sum * minimum; // Calculate final score
    }
    
    struct Pair {
        int nums1;
        int nums2;
    }
}
