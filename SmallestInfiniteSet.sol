// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SmallestInfiniteSet {
    uint private smallest = 1;
    mapping(uint => bool) private available;

    // Initializes the set to contain all positive integers starting from 1.
    constructor() {
        // Initially, `smallest` is 1 and the map `available` is empty.
    }

    // Removes and returns the smallest integer currently in the set.
    function popSmallest() public returns (uint) {
        uint currSmallest = smallest;
        
        // Find the next smallest number not explicitly stored in the map.
        while (available[smallest] == true) {
            delete available[smallest]; // Clean up to save gas
            smallest++;
        }
        
        // Increment smallest for the next call
        smallest++;
        
        // Return the current smallest number
        return currSmallest;
    }

    // Adds a number back into the set, if it isn't already there.
    function addBack(uint num) public {
        require(num > 0, "Number must be positive");

        // Only add back if the number is less than the current smallest
        if (num < smallest) {
            available[num] = true;
            // Update smallest if necessary
            if (num < smallest) {
                smallest = num;
            }
        }
    }
}
