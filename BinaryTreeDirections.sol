// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BinaryTreeDirections {
    struct TreeNode {
        uint val;
        uint left;
        uint right;
        uint parent;
    }

    mapping(uint => TreeNode) public tree;
    uint public root;

    constructor() {
        root = 1; // Example root value
        // Initialize the tree here with parent links
    }

    function findPath(uint startValue, uint destValue) public view returns (string memory) {
        if (startValue == destValue) {
            return "";
        }

        uint[] memory pathToStart = getPath(startValue);
        uint[] memory pathToDest = getPath(destValue);

        uint i = pathToStart.length - 1;
        uint j = pathToDest.length - 1;

        // Find the common ancestor
        while (i != 0 && j != 0 && pathToStart[i-1] == pathToDest[j-1]) {
            i--;
            j--;
        }

        // Construct the direction string
        bytes memory directions = new bytes(i + j);
        uint index = 0;

        // Add 'U' for each step up from startValue to the LCA
        for (uint k = 0; k < i; k++) {
            directions[index++] = 'U';
        }

        // Add 'L' or 'R' from LCA to destValue
        for (uint k = j; k > 0; k--) {
            uint parent = tree[pathToDest[k]].parent;
            uint current = pathToDest[k - 1];
            if (tree[parent].left == current) {
                directions[index++] = 'L';
            } else {
                directions[index++] = 'R';
            }
        }

        return string(directions);
    }

    function getPath(uint value) internal view returns (uint[] memory) {
        uint[] memory path = new uint[](100); // Assuming a max depth of 100
        uint index = 0;
        uint current = value;
        
        while (current != root) {
            path[index++] = current;
            current = tree[current].parent;
        }
        path[index++] = root;

        uint[] memory trimmedPath = new uint[](index);
        for (uint i = 0; i < index; i++) {
            trimmedPath[i] = path[index - 1 - i];
        }
        return trimmedPath;
    }
}
