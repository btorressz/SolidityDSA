// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract LongestSubarrayWithLimit {
    function longestSubarray(int[] memory nums, int limit) public pure returns (int) {
        uint left = 0;
        uint[] memory maxDeque = new uint[](nums.length);
        uint[] memory minDeque = new uint[](nums.length);
        uint maxLen = 0;
        uint maxD = 0;
        uint minD = 0;

        for (uint right = 0; right < nums.length; right++) {
            // Maintain maxDeque
            while (maxD > 0 && nums[maxDeque[maxD - 1]] < nums[right]) {
                maxD--;
            }
            maxDeque[maxD++] = right;

            // Maintain minDeque
            while (minD > 0 && nums[minDeque[minD - 1]] > nums[right]) {
                minD--;
            }
            minDeque[minD++] = right;

            // Shrink the window if the condition is violated
            while (nums[maxDeque[0]] - nums[minDeque[0]] > limit) {
                left++;
                if (maxDeque[0] < left) maxD--;
                if (minDeque[0] < left) minD--;
                for (uint i = 0; i < maxD; i++) {
                    maxDeque[i] = maxDeque[i + 1];
                }
                for (uint i = 0; i < minD; i++) {
                    minDeque[i] = minDeque[i + 1];
                }
            }

            // Update the max length of the subarray
            if (right - left + 1 > maxLen) {
                maxLen = right - left + 1;
            }
        }

        return int(maxLen);
    }
}
