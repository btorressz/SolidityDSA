// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract UniqueBSTs {
    struct TreeNode {
        int value;
        uint left;
        uint right;
    }

    mapping(uint => TreeNode) public tree;
    uint public nextNodeId = 1;  // Start indexing from 1 since 0 is used as 'null'
    int private maxSum = type(int).min;

    function createNode(int value, uint left, uint right) public returns (uint) {
        tree[nextNodeId] = TreeNode(value, left, right);
        return nextNodeId++;
    }

    function maxPathSum(uint rootId) public returns (int) {
        maxSum = type(int).min;
        maxGain(rootId);
        return maxSum;
    }

    function maxGain(uint nodeId) private returns (int) {
        if (nodeId == 0) {  // 0 represents null
            return 0;
        }

        TreeNode memory node = tree[nodeId];
        int leftGain = max(maxGain(node.left), 0);
        int rightGain = max(maxGain(node.right), 0);

        int priceNewpath = node.value + leftGain + rightGain;
        maxSum = max(maxSum, priceNewpath);

        return node.value + max(leftGain, rightGain);
    }

    function max(int a, int b) private pure returns (int) {
        return a >= b ? a : b;
    }
}
