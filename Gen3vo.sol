pragma solidity ^0.8.26;
// SPDX-License-Identifier: MIT
contract Gen3vo {
    address public owner;
    uint public taskCount;
    struct Task {
        string description;
        uint timestamp;
        address requester;
        bool ethicalFlag;
    }
    mapping(uint => Task) public tasks;
    event TaskSubmitted(uint indexed taskId, address indexed requester, string description);
    event EthicsFlagged(uint indexed taskId, string reason);
    modifier onlyOwner() { require(msg.sender == owner, 'Not authorized'); _; }
    constructor() { owner = msg.sender; }
    function submitTask(string memory description) public {
        require(bytes(description).length > 0, 'Empty description not allowed');
        tasks[taskCount] = Task(description, block.timestamp, msg.sender, false);
        emit TaskSubmitted(taskCount, msg.sender, description);
        taskCount++;
    }
    function flagEthics(uint taskId, string memory reason) public {
        require(taskId < taskCount, 'Invalid task ID');
        require(bytes(reason).length > 0, 'Reason cannot be empty');
        tasks[taskId].ethicalFlag = true;
        emit EthicsFlagged(taskId, reason);
    }
    function getTask(uint taskId) public view returns (
        string memory description,
        uint timestamp,
        address requester,
        bool ethicalFlag
    ) {
        require(taskId < taskCount, 'Task does not exist');
        Task memory t = tasks[taskId];
        return (t.description, t.timestamp, t.requester, t.ethicalFlag);
    }
    function transferOwnership(address newOwner) public onlyOwner {
        require(newOwner != address(0), 'Zero address not allowed');
        owner = newOwner;
    }
}
