// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract FrequencyCounter {
    // Mapping to store frequencies of elements
    mapping(uint => uint) private frequencies;

    // Array to store unique elements for which frequencies are counted
    uint[] private uniqueElements;

    // Function to count frequencies of array elements
    function countFrequencies(uint[] calldata elements) public {
        // Reset the frequencies from previous counts
        for (uint i = 0; i < uniqueElements.length; i++) {
            delete frequencies[uniqueElements[i]];
        }
        delete uniqueElements;

        // Count frequencies of current array elements
        for (uint i = 0; i < elements.length; i++) {
            if (frequencies[elements[i]] == 0) {
                // First time this element is encountered
                uniqueElements.push(elements[i]);
            }
            frequencies[elements[i]]++;
        }
    }

    // Function to get the frequency of a specific element
    function getFrequency(uint element) public view returns (uint) {
        return frequencies[element];
    }

    // Function to get all unique elements and their frequencies
    function getFrequencies() public view returns (uint[] memory, uint[] memory) {
        uint[] memory freqs = new uint[](uniqueElements.length);
        for (uint i = 0; i < uniqueElements.length; i++) {
            freqs[i] = frequencies[uniqueElements[i]];
        }
        return (uniqueElements, freqs);
    }
}
