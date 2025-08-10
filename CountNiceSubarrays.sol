// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CountNiceSubarrays {
    function countNiceSubarrays(uint[] memory nums, uint k) public pure returns (uint) {
        uint count = 0;
        uint left = 0;
        uint right = 0;
        uint oddCount = 0;

        while (right < nums.length) {
            // If it's an odd number, increment the odd count
            if (nums[right] % 2 != 0) {
                oddCount++;
            }

            // Once we have exactly k odd numbers, we start counting possible subarrays
            while (oddCount > k) {
                if (nums[left] % 2 != 0) {
                    oddCount--;
                }
                left++;
            }

            // For each position of the right pointer, count how many subarrays end here
            // that have exactly k odd numbers.
            if (oddCount == k) {
                uint tempLeft = left;
                while (oddCount == k) {
                    if (nums[tempLeft] % 2 != 0) {
                        count += (tempLeft - left + 1);  // Count all valid subarrays ending here
                        break;
                    }
                    tempLeft++;
                }
            }
            
            right++; // Expand the window
        }

        return count;
    }
}
