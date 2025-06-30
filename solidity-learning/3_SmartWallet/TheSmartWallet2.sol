//SPDX-License-Identifier: MIT

pragma solidity 0.8.16;

contract SmartWallet {
    address payable owner;
    mapping(address => uint) allowance;

    address[] public guardians;
    mapping(address => mapping(address => bool)) guardianVotes; //First address is guardians, second is candidate's and bool to check if already voted for said candidate
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

    function _isGuardian(address _guardian) internal view returns (bool) {
        for(uint i=0;i<guardians.length;i++) {
            if(guardians[i]==_guardian)
                return true;
        }
        return false;
    }

    function addGuardian(address _guardian) public {
        require(msg.sender == owner, "You are not the owner, aborting");
        if(!_isGuardian(_guardian)) {
            guardians.push(_guardian);
        }
    }

    function markVote(address _myVote) public {
        require(_isGuardian(msg.sender), "You are not a guardian, aborting");
        require(!guardianVotes[msg.sender][_myVote],"You have already voted for this candidate");
        if(_myVote != currentCandidate ) {
            resetAllGuardianForCandidate(currentCandidate);
            currentCandidate = _myVote;
            currentVotes=1;
            guardianVotes[msg.sender][_myVote]=true;
        }
        else {
            currentVotes++;
            guardianVotes[msg.sender][_myVote]=true;
        }

        if(currentVotes >= numVotesToPass) {
            owner = payable(currentCandidate);
            resetAllGuardianForCandidate(currentCandidate);
            currentCandidate = address(0);
            currentVotes=0;
            
        }
    }

    function resetAllGuardianForCandidate(address _candidate) internal {
        for(uint i=0;i<guardians.length;i++) {
            guardianVotes[guardians[i]][_candidate]=false;
        }
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