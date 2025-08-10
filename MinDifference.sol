// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MinDifference {
    function minDifference(int[] memory nums) public pure returns (int) {
        uint n = nums.length;
        if (n <= 4) return 0;

        int[] memory sorted = sortArray(nums);
        
        // Check the minimum of four strategies
        int res = sorted[n-1] - sorted[0]; // no change
        // Remove the three largest or three smallest elements
        res = min(res, sorted[n-4] - sorted[0]); // Remove the three largest
        res = min(res, sorted[n-1] - sorted[3]); // Remove the three smallest
        // Remove two from one end and one from the other
        res = min(res, sorted[n-2] - sorted[2]); // Remove two largest, one smallest
        res = min(res, sorted[n-3] - sorted[1]); // Remove two smallest, one largest
        
        return res;
    }
    
    function min(int a, int b) private pure returns (int) {
        return a < b ? a : b;
    }

    // Simple selection sort for demonstration; use more efficient sort for larger arrays.
    function sortArray(int[] memory arr) private pure returns (int[] memory) {
        uint n = arr.length;
        for (uint i = 0; i < n; i++) {
            uint minIndex = i;
            for (uint j = i + 1; j < n; j++) {
                if (arr[j] < arr[minIndex]) {
                    minIndex = j;
                }
            }
            // Swap
            if (minIndex != i) {
                int temp = arr[i];
                arr[i] = arr[minIndex];
                arr[minIndex] = temp;
            }
        }
        return arr;
    }
}
