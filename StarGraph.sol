// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract StarGraph {
    // Function to find the center of a star graph
    function findCenter(int[][] memory edges) public pure returns (int) {
        // The center node will be the common node in the first two edges
        int node1 = edges[0][0];
        int node2 = edges[0][1];
        int node3 = edges[1][0];
        int node4 = edges[1][1];

        // Check if the first node of the first edge is the center
        if (node1 == node3 || node1 == node4) {
            return node1;
        }
        
        // Otherwise, the second node of the first edge must be the center
        return node2;
    }
}
