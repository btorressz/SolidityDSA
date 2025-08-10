// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract GraphWithBFS {
    // Mapping from vertex identifier to list of neighbor vertices
    mapping(uint => uint[]) public adjacencyList;

    // Maximum number of vertices (for example purposes)
    uint constant MAX_VERTICES = 1000;

    // Adds an edge between two vertices (undirected graph for simplicity)
    function addEdge(uint _vertex1, uint _vertex2) public {
        adjacencyList[_vertex1].push(_vertex2);
        adjacencyList[_vertex2].push(_vertex1); // Comment this for a directed graph
    }

    // Function to perform BFS and find the shortest path from start to target vertex
    function findShortestPath(uint start, uint target) public view returns (uint, uint[] memory) {
        require(adjacencyList[start].length > 0, "Start vertex does not exist");
        require(adjacencyList[target].length > 0, "Target vertex does not exist");

        uint[] memory queue = new uint[](MAX_VERTICES);
        uint[] memory distance = new uint[](MAX_VERTICES);
        uint[] memory previous = new uint[](MAX_VERTICES);
        bool[] memory visited = new bool[](MAX_VERTICES);
        uint front = 0;
        uint back = 0;

        // Initialize BFS
        queue[back++] = start;
        visited[start] = true;
        for(uint i = 0; i < MAX_VERTICES; i++) {
            distance[i] = type(uint).max;
            previous[i] = type(uint).max;
        }
        distance[start] = 0;

        while (front < back) {
            uint current = queue[front++];
            for (uint i = 0; i < adjacencyList[current].length; i++) {
                uint neighbor = adjacencyList[current][i];
                if (!visited[neighbor]) {
                    visited[neighbor] = true;
                    distance[neighbor] = distance[current] + 1;
                    previous[neighbor] = current;
                    queue[back++] = neighbor;
                }
            }
        }

        // Construct the path if the target has been reached
        if (!visited[target] || previous[target] == type(uint).max) {
            return(0, new uint[](0));
        }

        // Calculate path size and allocate memory
        uint pathSize = 0;
        for(uint at = target; at != start; at = previous[at]) {
            pathSize++;
        }
        pathSize++; // Include start vertex

        uint[] memory path = new uint[](pathSize);
        uint pathIndex = pathSize;
        for(uint at = target; at != type(uint).max; at = previous[at]) {
            path[--pathIndex] = at;
            if(at == start) break;
        }

        return (distance[target], path);
    }
}