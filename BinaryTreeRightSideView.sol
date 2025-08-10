// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BinaryTreeRightSideView {
    int[] public tree;  // Tree is stored as an array, root is at index 0

    // Function to set the entire tree at once for simplicity
    function setTree(int[] memory _tree) public {
        tree = _tree;
    }

    // Function to get the right side view of the binary tree
    function rightSideView() public view returns (int[] memory) {
        if (tree.length == 0) {
            return new int[](height(uint(tree.length))); 
        }

        int[] memory result = new int[](height(tree.length));
        uint levelStart = 0; // Start index of the current level
        uint levelEnd = 0; // End index of the current level

        for (uint level = 0; level < result.length; level++) {
            levelEnd = (2 ** (level + 1)) - 2; // Calculate the end index of the level
            levelEnd = (levelEnd < tree.length) ? levelEnd : tree.length - 1; // Adjust if the end index exceeds the tree length
            
            if (levelStart <= levelEnd) {
                result[level] = tree[levelEnd]; // Take the last node in the current level
            }

            levelStart = (2 ** level) - 1; // Calculate the start index for the next level
        }
        return result;
    }

    // Function to calculate the height of the tree to determine number of levels
    function height(uint length) private pure returns (uint) {
        uint h = 0;
        while ((2 ** h) - 1 < length) {
            h++;
        }
        return h;
    }
}
