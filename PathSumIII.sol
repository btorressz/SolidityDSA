// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract PathSumIII {
    struct TreeNode {
        int value;
        uint left;
        uint right;
        bool exists;
    }

    TreeNode[] public tree;
    uint public rootIndex;

    constructor() {
        tree.push(TreeNode(0, 0, 0, false)); // Dummy node to start index at 1
    }

    function createNode(int _value, uint _left, uint _right) public returns (uint) {
        tree.push(TreeNode(_value, _left, _right, true));
        return tree.length - 1;
    }

    function setRoot(uint _index) public {
        rootIndex = _index;
    }

    function pathSum(uint _nodeIndex, int _targetSum) public view returns (uint) {
        if (_nodeIndex == 0 || !tree[_nodeIndex].exists) {
            return 0;
        }

        uint pathCount = pathSumFromNode(_nodeIndex, _targetSum, 0);
        uint leftCount = pathSum(tree[_nodeIndex].left, _targetSum);
        uint rightCount = pathSum(tree[_nodeIndex].right, _targetSum);

        return pathCount + leftCount + rightCount;
    }

    function pathSumFromNode(uint _nodeIndex, int _targetSum, int _currentSum) private view returns (uint) {
        if (_nodeIndex == 0 || !tree[_nodeIndex].exists) {
            return 0;
        }

        _currentSum += tree[_nodeIndex].value;
        uint pathCount = 0;
        if (_currentSum == _targetSum) {
            pathCount = 1;
        }

        pathCount += pathSumFromNode(tree[_nodeIndex].left, _targetSum, _currentSum);
        pathCount += pathSumFromNode(tree[_nodeIndex].right, _targetSum, _currentSum);

        return pathCount;
    }
}
