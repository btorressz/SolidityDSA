// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MaximumLevelSumBinaryTree {
    struct TreeNode {
        int val;
        uint leftIndex;
        uint rightIndex;
    }

    TreeNode[] public tree;

    function maxLevelSum(TreeNode[] memory _tree) public pure returns (uint) {
        uint n = _tree.length;
        uint[] memory levelSums = new uint[](n); // Assuming the tree has at most n levels

        for (uint i = 0; i < n; i++) {
            TreeNode memory node = _tree[i];
            if (node.val != 0) {
                levelSums[i] += uint(node.val);
            }
        }

        uint maxSum = 0;
        uint maxLevel = 0;

        for (uint i = 0; i < n; i++) {
            if (levelSums[i] > maxSum) {
                maxSum = levelSums[i];
                maxLevel = i + 1;
            }
        }

        return maxLevel;
    }
}
