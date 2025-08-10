// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MajorityElement {
    // Function to find the majority element that appears more than n/2 times
    function findMajorityElement(int[] memory data) public pure returns (int majorityElement) {
        int count = 0;
        int candidate = 0;

        for (uint i = 0; i < data.length; i++) {
            if (count == 0) {
                candidate = data[i];
            }
            if (data[i] == candidate) {
                count++;
            } else {
                count--;
            }
        }

        // Second pass to confirm the candidate is the majority element
        count = 0;
        for (uint i = 0; i < data.length; i++) {
            if (data[i] == candidate) {
                count++;
            }
        }

        require(count > int(data.length) / 2, "No majority element");
        return candidate;
    }
}
