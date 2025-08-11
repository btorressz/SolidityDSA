// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SubarraySumsDivisibleByK   {
    mapping(int => uint) public remainderCount;
    
    function subarraysDivByK(int[] memory nums, int k) public pure returns (int) {
        uint n = nums.length;
        int cumulativeSum = 0;
        uint result = 0;
        
        // Initialize the mapping with the remainder 0 having one occurrence to handle the subarray that starts from index 0
        remainderCount[0] = 1;

        for (uint i = 0; i < n; i++) {
            cumulativeSum += nums[i];
            // Safe modulo operation for negative numbers
            int mod = ((cumulativeSum % k) + k) % k;
            if(remainderCount[mod] > 0){
                result += remainderCount[mod];
            }
            remainderCount[mod]++;
        }
        
        return result;
    }
}