// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ReverseString {
    function reverseString(bytes1[] memory s) public pure returns (bytes1[] memory) {
        uint start = 0;
        uint end = s.length - 1;
        
        while (start < end) {
            // Swap elements at start and end
            (s[start], s[end]) = (s[end], s[start]);
            
            // Move pointers towards the center
            start++;
            end--;
        }

        return s;
    }
}
