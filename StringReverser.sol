// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract StringReverser {
     // Function to reverse a string
    function reverseString(string memory original) public pure returns (string memory) {
        bytes memory originalBytes = bytes(original);
        uint length = originalBytes.length;
        bytes memory reversedBytes = new bytes(length);

        for (uint i = 0; i < length; i++) {
            reversedBytes[length - i - 1] = originalBytes[i];
        }

        return string(reversedBytes);
    }
}