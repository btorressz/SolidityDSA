// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TowerOfHanoi {
    string public moves;

    // Constructor to initialize the moves string
    constructor() {
        moves = "";
    }

    // Function to solve the Tower of Hanoi puzzle
    function solveHanoi(uint disks, string memory fromPeg, string memory toPeg, string memory auxPeg) public {
        moves = "";  // Reset moves string each time the function is called
        _moveDisks(disks, fromPeg, toPeg, auxPeg);
    }

    // Recursive helper function to move disks
    function _moveDisks(uint disks, string memory fromPeg, string memory toPeg, string memory auxPeg) internal {
        if (disks == 1) {
            // Move disk from source peg to destination peg
            moves = string(abi.encodePacked(moves, "Move disk from ", fromPeg, " to ", toPeg, "; "));
        } else {
            // Move top n-1 disks from source to auxiliary, so they are out of the way
            _moveDisks(disks - 1, fromPeg, auxPeg, toPeg);

            // Move the nth disk from source to destination
            _moveDisks(1, fromPeg, toPeg, auxPeg);

            // Move the n-1 disks from auxiliary to destination
            _moveDisks(disks - 1, auxPeg, toPeg, fromPeg);
        }
    }
}
