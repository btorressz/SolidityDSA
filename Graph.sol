// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Graph {
    // Mapping from vertex identifier to list of neighbors
    mapping(uint => uint[]) public adjacencyList;

    // Adds a vertex to the graph
    function addVertex(uint _vertexId) public {
        // Initialize the adjacency list with an empty array if not already added
        if (adjacencyList[_vertexId].length == 0) {
            adjacencyList ;
        }
    }

    // Adds an edge from vertex `_vertex1` to vertex `_vertex2`
    function addEdge(uint _vertex1, uint _vertex2) public {
        // Ensure that both vertices exist in the graph
        require(adjacencyList[_vertex1].length != 0, "Vertex 1 does not exist.");
        require(adjacencyList[_vertex2].length != 0, "Vertex 2 does not exist.");

        // Add the edge by adding vertex2 to the adjacency list of vertex1
        // and vice versa if undirected graph is required
        adjacencyList[_vertex1].push(_vertex2);
        adjacencyList[_vertex2].push(_vertex1); // Comment this line for a directed graph
    }

    // Get the neighbors of a vertex
    function getNeighbors(uint _vertex) public view returns (uint[] memory) {
        return adjacencyList[_vertex];
    }

    // Check if there is an edge between two vertices
    function areConnected(uint _vertex1, uint _vertex2) public view returns (bool) {
        // Check all neighbors of vertex1 to see if vertex2 is one of them
        for (uint i = 0; i < adjacencyList[_vertex1].length; i++) {
            if (adjacencyList[_vertex1][i] == _vertex2) {
                return true;
            }
        }
        return false;
    }
}
