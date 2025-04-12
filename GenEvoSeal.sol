pragma solidity ^0.8.0;

contract GenEvoSeal {

    struct Seal {
        string timestamp;
        string origin;
        string tag;
        string hash;
        string message;
    }

    address public owner;
    uint public sealCount = 0;

    mapping(uint => Seal) public seals;

    event SealLogged(
        uint indexed sealId,
        string timestamp,
        string origin,
        string tag,
        string hash,
        string message
    );

    constructor() {
        owner = msg.sender;
    }

    function logSeal(
        string memory _timestamp,
        string memory _origin,
        string memory _tag,
        string memory _hash,
        string memory _message
    ) public returns (uint) {
        sealCount++;
        seals[sealCount] = Seal(_timestamp, _origin, _tag, _hash, _message);

        emit SealLogged(sealCount, _timestamp, _origin, _tag, _hash, _message);
        return sealCount;
    }

    function getSeal(uint _id) public view returns (
        string memory, string memory, string memory, string memory, string memory
    ) {
        Seal memory s = seals[_id];
        return (s.timestamp, s.origin, s.tag, s.hash, s.message);
    }
}
