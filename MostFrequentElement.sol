// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MostFrequentElement {
    // Assuming elements are between 0 and a known maximum value
    function findMostFrequent(uint[] memory data) public pure returns (uint mostFrequent, uint frequency) {
        require(data.length > 0, "Array is empty.");

        // You must know the maximum element value to use this method
        uint maxValue = 255;  // Example max value, adjust based on your data
        uint[] memory counts = new uint[](maxValue + 1);
        uint maxCount = 0;
        uint maxElement = data[0];

        for (uint i = 0; i < data.length; i++) {
            uint element = data[i];
            counts[element]++;

            if (counts[element] > maxCount) {
                maxCount = counts[element];
                maxElement = element;
            }
        }

        return (maxElement, maxCount);
    }
}
