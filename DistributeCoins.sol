// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DistributeCoins {
    struct TreeNode {
        uint val;
        uint left;   // index of the left child
        uint right;  // index of the right child
        bool exists;
    }

    TreeNode[] public tree;
    uint public totalMoves = 0;

    // Constructor to initialize the binary tree
    constructor(uint[] memory values, uint[] memory leftChildren, uint[] memory rightChildren) {
        for (uint i = 0; i < values.length; i++) {
            tree.push(TreeNode({
                val: values[i],
                left: leftChildren[i],
                right: rightChildren[i],
                exists: true
            }));
        }
    }

    // Main function to start distributing coins
    function distributeCoins() public returns (uint) {
        distribute(0);  // Assuming root is at index 0
        return totalMoves;
    }

    // Recursive function to distribute coins and calculate moves
    function distribute(uint index) private returns (int) {
        if (index == type(uint).max || !tree[index].exists) return 0; // Base case for non-existent nodes

        int leftExcess = distribute(tree[index].left);
        int rightExcess = distribute(tree[index].right);

        // Calculate total excess at current node
        int totalExcess = int(tree[index].val) + leftExcess + rightExcess - 1;

        // Increment total moves by the number of moves needed to balance current node
        totalMoves += uint(abs(totalExcess));

        return totalExcess;
    }

    // Helper function to calculate the absolute value
    function abs(int x) private pure returns (int) {
        return x < 0 ? -x : x;
    }
}
