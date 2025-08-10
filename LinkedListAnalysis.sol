// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract LinkedListAnalysis {
    struct Node {
        uint value;
        uint next; // Using index for next to simplify the structure in Solidity
    }

    Node[] public nodes;

    // Helper function to add nodes to the list
    function addNode(uint value) public {
        nodes.push(Node(value, 0));
        if (nodes.length > 1) {
            nodes[nodes.length - 2].next = nodes.length - 1;
        }
    }

    // Function to find the minimum and maximum distances between critical points
    function findCriticalPointsDistance() public view returns (int, int) {
        if (nodes.length < 3) return (-1, -1);

        uint lastCriticalPoint = 0;
        bool foundFirstCriticalPoint = false;
        uint minDistance = type(uint).max;
        uint maxDistance = 0;
        uint firstCriticalIndex = 0;

        // Iterate over the linked list to find critical points
        for (uint i = 1; i < nodes.length - 1; i++) {
            if ((nodes[i].value > nodes[i-1].value && nodes[i].value > nodes[nodes[i].next].value) || 
                (nodes[i].value < nodes[i-1].value && nodes[i].value < nodes[nodes[i].next].value)) {
                if (foundFirstCriticalPoint) {
                    uint distance = i - lastCriticalPoint;
                    if (distance < minDistance) {
                        minDistance = distance;
                    }
                    if (distance > maxDistance) {
                        maxDistance = distance;
                    }
                } else {
                    firstCriticalIndex = i;
                    foundFirstCriticalPoint = true;
                }
                lastCriticalPoint = i;
            }
        }

        // If we have found at least two critical points, calculate distances
        if (maxDistance == 0) {
            return (-1, -1);  // Less than two critical points found
        }

        return (int(minDistance), int(maxDistance));
    }
}
