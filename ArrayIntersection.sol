// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ArrayIntersection {
    mapping(uint => bool) elementPresent;

    // Function to find the intersection of two unsorted arrays without duplicates
    function findIntersection(uint[] memory array1, uint[] memory array2) public returns (uint[] memory) {
        // Reset elementPresent mapping for each new function call
        for (uint i = 0; i < array1.length; i++) {
            elementPresent[array1[i]] = true;
        }

        // Temporary array to store the intersection
        uint[] memory temp = new uint[](array1.length < array2.length ? array1.length : array2.length);
        uint count = 0;

        // Check elements of array2 against the mapping
        for (uint j = 0; j < array2.length; j++) {
            if (elementPresent[array2[j]]) {
                temp[count++] = array2[j];
                // Once added to the result, set false to avoid duplicates if array2 contains duplicates
                elementPresent[array2[j]] = false;
            }
        }

        // Reset the mapping for the next function call
        for (uint i = 0; i < array1.length; i++) {
            elementPresent[array1[i]] = false;
        }

        // Copy the result into a properly sized array
        uint[] memory intersection = new uint[](count);
        for (uint k = 0; k < count; k++) {
            intersection[k] = temp[k];
        }

        return intersection;
    }
}
