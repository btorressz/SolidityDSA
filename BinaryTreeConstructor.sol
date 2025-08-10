// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BinaryTreeConstructor {
    struct Node {
        uint value;
        uint leftChild;
        uint rightChild;
    }
    
    mapping(uint => Node) public nodes;

    function constructBinaryTree(uint[][] calldata descriptions) public returns (uint) {

        for (uint i = 0; i < descriptions.length; i++) {
            uint parent = descriptions[i][0];
            uint child = descriptions[i][1];
            uint isLeft = descriptions[i][2];
            
            // Create child node if it doesn't exist
            if (nodes[child].value == 0) {
                nodes[child].value = child;
            }
            
            // Link child to parent
            if (isLeft == 1) {
                nodes[parent].leftChild = child;
            } else {
                nodes[parent].rightChild = child;
            }
        }
        
        //  Find the root node
        uint rootNode = 0;
        for (uint j = 1; j <= 100000; j++) { // assuming node values are within 1 to 100000
            if (nodes[j].value != 0 && nodes[j].leftChild == 0 && nodes[j].rightChild == 0) {
                rootNode = j;
                break;
            }
        }
        
        return rootNode;
    }
}
