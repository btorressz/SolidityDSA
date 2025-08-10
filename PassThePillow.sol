// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract PassThePillow {
    function findPillowHolder(uint n, uint time) public pure returns (uint) {
        // Calculate the total cycle length
        uint cycleLength = (n - 1) * 2;

        // Determine the effective time after cycles
        uint effectiveTime = time % cycleLength;

        // Simulate the pillow passing
        uint position;
        if (effectiveTime < n) {
            // Moving forward from 1 to n
            position = effectiveTime + 1;
        } else {
            // Moving backward from n to 2
            position = n - (effectiveTime - n + 1);
        }

        return position;
    }
}
