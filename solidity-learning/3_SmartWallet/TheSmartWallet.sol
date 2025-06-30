//SPDX-License-Identifier: MIT

pragma solidity 0.8.16;

contract SmartWallet {
    struct GuardianBody {
        bool isGuardian;
        mapping(address => bool) hasVoteForThisCandidate;
    }
    address payable owner;
    mapping(address => uint) allowance;
    mapping(address => GuardianBody) guardians;
    address public currentCandidate;
    uint public currentVotes;
    uint constant numVotesToPass = 3;

    constructor () {
        owner = payable(msg.sender);
    }

    function viewOwner() public view returns (address) {
        return owner;
    }

    function setAllowance(address _spender, uint _allowance) public {
        require(msg.sender == owner, "You are not the owner, aborting");
        allowance[_spender] = _allowance;
    }

    function addGuardian(address _guardian) public {
        require(msg.sender == owner, "You are not the owner, aborting");
        guardians[_guardian].isGuardian = true;
    }

    function markVote(address _myVote) public {
        require(guardians[msg.sender].isGuardian, "You are not a guardian, aborting");
        require(!guardians[msg.sender].hasVoteForThisCandidate[_myVote],"You have already vote for this candidate");
        if(_myVote != currentCandidate ) {
            currentCandidate = _myVote;
            currentVotes=1;
            guardians[msg.sender].hasVoteForThisCandidate[_myVote] = true;
        }
        else {
            currentVotes++;
            guardians[msg.sender].hasVoteForThisCandidate[_myVote] = true;
        }

        if(currentVotes >= numVotesToPass) {
            owner = payable(currentCandidate);
            currentCandidate = address(0);
            currentVotes=0;
            resetAllGuardians();
        }
    }

    function resetAllGuardians() internal {
        //Code to reset all guardians and/or their votes
    }

    function viewAllowance() public view returns (uint) {
        return allowance[msg.sender];
    }

    function transferFunds(address payable _to, uint _amount) public {
        require(_amount<=address(this).balance, "The contract doesn't have sufficient balance");
        if(msg.sender != owner) {
            require(allowance[msg.sender]!=0,"You don't have any allowance, aborting");
            require(allowance[msg.sender]>=_amount,"Your request amount exceeds your remaining allowance");
            (bool isSuccess,) = _to.call{value:_amount}("");
            require(isSuccess,"Call Failed, aborting");
            allowance[msg.sender] -= _amount;
        }
        else {
            (bool isSuccess,) = _to.call{value:_amount}("");
            require(isSuccess,"Call Failed, aborting");
        }
    }

    receive() external payable { }
}