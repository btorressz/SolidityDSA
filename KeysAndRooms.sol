// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract KeysAndRooms {
    function canVisitAllRooms(uint[][] memory rooms) public pure returns (bool) {
        uint n = rooms.length;
        bool[] memory visited = new bool[](n);
        dfs(rooms, visited, 0);
        
        for (uint i = 0; i < n; i++) {
            if (!visited[i]) {
                return false;
            }
        }
        
        return true;
    }
    
    function dfs(uint[][] memory rooms, bool[] memory visited, uint room) private pure {
        visited[room] = true;
        
        for (uint i = 0; i < rooms[room].length; i++) {
            uint nextRoom = rooms[room][i];
            if (!visited[nextRoom]) {
                dfs(rooms, visited, nextRoom);
            }
        }
    }
}
