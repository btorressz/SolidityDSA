// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MerkleTree {
    bytes32[] public hashes;  // This array will store the hashes at all levels of the tree

    // Function to insert a new leaf into the Merkle tree
    function insert(bytes32 data) public {
        hashes.push(data);  // Insert the leaf hash at the end of the array

        uint n = hashes.length;
        uint offset = 1;
        while (offset * 2 <= n) {
            offset *= 2;
        }
        offset /= 2;

        // Start from the last inserted leaf and build up the tree
        for (uint i = offset; i > 0; i /= 2) {
            for (uint j = 0; j < i; j++) {
                if (2 * j + 1 + i < n) {
                    // Compute parent hash as hash of two children hashes
                    hashes[i + j - 1] = keccak256(abi.encodePacked(hashes[2 * j + i], hashes[2 * j + i + 1]));
                }
            }
        }
    }

    // Function to get the root of the Merkle tree
    function getRoot() public view returns (bytes32) {
        if (hashes.length == 0) {
            return bytes32(0);
        }
        return hashes[0];  // The root of the tree is the first element
    }

    // Helper function to calculate the hash of two data elements
    function hashPair(bytes32 a, bytes32 b) public pure returns (bytes32) {
        return keccak256(abi.encodePacked(a, b));
    }
}
