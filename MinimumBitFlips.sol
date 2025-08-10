// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MinimumBitFlips {
    function minFlips(int a, int b, int c) public pure returns (int) {
        int flips = 0;
        for (uint i = 0; i < 32; i++) { // iterate through each bit position
            int aBit = (a >> i) & 1; // get i-th bit of a
            int bBit = (b >> i) & 1; // get i-th bit of b
            int cBit = (c >> i) & 1; // get i-th bit of c

            if (cBit == 0) {
                // If c's bit is 0, both a and b bits should be 0
                flips += aBit + bBit; // flips needed for a and b to be 0
            } else {
                // If c's bit is 1, at least one of a or b should have the bit set to 1
                if (aBit == 0 && bBit == 0) {
                    flips++; // if both are 0, one needs to flip
                }
            }
        }
        return flips;
    }
}
