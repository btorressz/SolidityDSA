// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TheBinaryTree {
    struct Node {
        int value;
        uint left;  // Index of left child
        uint right; // Index of right child
    }

    Node[] public nodes;

    // Constructor to initialize the tree
    constructor() {
        // Dummy initial value
        nodes.push(Node(0, 0, 0));
        // Manually adding nodes might look like this:
        // nodes.push(Node(3, 2, 3)); // index 1
        // nodes.push(Node(5, 4, 5)); // index 2
        // nodes.push(Node(1, 6, 7)); // index 3
        // and so on...
    }

    // Function to add a node to the tree
    function addNode(int value, uint left, uint right) public {
        nodes.push(Node(value, left, right));
    }

    // Function to find LCA
    function findLCA(uint index, int p, int q) public view returns (int) {
        if (index == 0 || nodes[index].value == p || nodes[index].value == q) {
            return nodes[index].value;
        }

        uint leftIndex = nodes[index].left;
        uint rightIndex = nodes[index].right;

        int leftLCA = (leftIndex != 0) ? findLCA(leftIndex, p, q) : -1;
        int rightLCA = (rightIndex != 0) ? findLCA(rightIndex, p, q) : -1;

        if (leftLCA != -1 && rightLCA != -1) {
            return nodes[index].value;
        }
        return (leftLCA != -1) ? leftLCA : rightLCA;
    }
}
