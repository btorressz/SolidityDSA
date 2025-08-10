// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract LargestPositiveInteger {
    // Function to find the largest positive integer k such that -k also exists in the array
    function largestK(int[] memory nums) public pure returns (int) {
        bool[] memory presence = new bool[](1000001); // Assuming maximum value of numbers in nums array

        int maxPositive = -1;

        // Populate the array with presence of each number
        for (uint i = 0; i < nums.length; i++) {
            presence[uint(nums[i])] = true;
        }

        // Check for the largest k that has its negative in the array
        for (uint i = 0; i < nums.length; i++) {
            if (nums[i] > 0 && nums[i] <= 500000 && presence[uint(-nums[i])]) {
                if (nums[i] > maxPositive) {
                    maxPositive = nums[i];
                }
            }
        }

        return maxPositive;
    }
}

/*

pragma solidity ^0.8.0;

contract LargestPositiveInteger {
    // Function to find the largest positive integer k such that -k also exists in the array
    function largestK(int[] memory nums) public pure returns (int) {
        bool[] memory presence = new bool[](1000001); // Assuming maximum value of numbers in nums array

        int largestK = -1;

        // Populate the array with presence of each number
        for (uint i = 0; i < nums.length; i++) {
            presence[uint(nums[i])] = true;
        }

        // Check for the largest k that has its negative in the array
        for (uint i = 0; i < nums.length; i++) {
            if (nums[i] > 0 && nums[i] <= 500000 && presence[uint(-nums[i])]) {
                if (nums[i] > largestK) {
                    largestK = nums[i];
                }
            }
        }

        return largestK;
    }
}
