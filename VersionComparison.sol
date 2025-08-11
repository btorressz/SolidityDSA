// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract VersionComparison {
    // Function to compare two version numbers
    function compareVersion(string memory version1, string memory version2) public pure returns (int) {
        // Split both version strings by '.'
        bytes memory v1 = bytes(version1);
        bytes memory v2 = bytes(version2);
        
        uint i = 0;
        uint j = 0;
        
        while (i < v1.length || j < v2.length) {
            uint num1 = 0;
            uint num2 = 0;
            
            // Process the next number from version1
            while (i < v1.length && v1[i] != '.') {
                num1 = num1 * 10 + uint8(v1[i]) - uint8(bytes1('0'));
                i++;
            }
            
            // Skip the dot
            if (i < v1.length && v1[i] == '.') {
                i++;
            }
            
            // Process the next number from version2
            while (j < v2.length && v2[j] != '.') {
                num2 = num2 * 10 + uint8(v2[j]) - uint8(bytes1('0'));
                j++;
            }
            
            // Skip the dot
            if (j < v2.length && v2[j] == '.') {
                j++;
            }
            
            // Compare the numbers
            if (num1 < num2) return -1;
            if (num1 > num2) return 1;
        }
        
        // If all numbers are equal
        return 0;
    }
}
