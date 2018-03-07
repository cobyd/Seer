pragma solidity ^0.4.18;

contract Nostradamus {
    mapping (address => bool) public prophets;

    event LogProphecised(address indexed who, bytes32 indexed exact);

    function Nostradamus() public {
    }

    function prophecise(bytes32 exact) public {
        uint blockNumber = block.number;
        bytes32 blockHash = block.blockhash(blockNumber);
        require(keccak256(msg.sender, blockNumber, blockHash, block.timestamp, this) == exact);
        prophets[msg.sender] = true;
        LogProphecised(msg.sender, exact);
    }

    function theWord() public view returns(bytes32 exact) {
        uint blockNumber = block.number;
        bytes32 blockHash =block.blockhash(block.number);
        return keccak256(msg.sender, blockHash, blockNumber, block.timestamp, this);
    }
}

contract Seer {
    Nostradamus target;
    
    function Seer(Nostradamus _target) public {
        target = _target;
    }
    
    function See() public {
        uint blockNumber = block.number;
        bytes32 blockHash = block.blockhash(blockNumber);
        bytes32 prediction = keccak256(this, blockNumber, blockHash, block.timestamp, target);
        target.prophecise(prediction);
    }
}