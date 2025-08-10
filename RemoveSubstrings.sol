// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract RemoveSubstrings {
    function maxScoreFromRemovingSubstrings(string memory s, uint x, uint y) public pure returns (uint) {
        // Determine the order of removal based on point values
        string memory first = x >= y ? "ab" : "ba";
        string memory second = x >= y ? "ba" : "ab";
        uint firstPoints = x >= y ? x : y;
        uint secondPoints = x >= y ? y : x;

        // Use a bytes array to simulate stack operations
        bytes memory b = bytes(s);
        bytes memory stack = new bytes(b.length);
        uint stackPointer = 0;

        uint score = 0;
        for (uint i = 0; i < b.length; ++i) {
            // Simulate stack operations
            if (stackPointer > 0 && (b[i] == bytes(first)[1] && stack[stackPointer - 1] == bytes(first)[0])) {
                --stackPointer; // Simulate popping from stack
                score += firstPoints; // Gain points for removing the first substring
            } else {
                stack[stackPointer++] = b[i];
            }
        }

        // Second pass for the second pattern
        uint finalStackSize = stackPointer;
        stackPointer = 0;
        bytes memory finalStack = new bytes(finalStackSize);
        for (uint i = 0; i < finalStackSize; ++i) {
            if (stackPointer > 0 && (stack[i] == bytes(second)[1] && finalStack[stackPointer - 1] == bytes(second)[0])) {
                --stackPointer;
                score += secondPoints;
            } else {
                finalStack[stackPointer++] = stack[i];
            }
        }

        return score;
    }
}
