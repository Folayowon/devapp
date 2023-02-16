// MIT-License-Identifier:
pragma solidity ^0.8.9;


//* @ this is to import the dependencies required for some functions in this code
import "@openzeppelin/contracts/utils/Counters.sol";
import "hardhat/console.sol";


// this contract is creates a list of candidates,
// and maps the details of each candidate sequentially,
// it also creates a list of  voters,
// and maps the details of each voter sequentially,

// the deployer's contract is attached as the authorizer and the authorizer can create
// add candidates and voters (only the authorizer will be able to perform these functions)
// the authorizer can also start the election and the election will end once the time's elapsed.


// Each voter can only vote once and have to connect with their wallet to interact with the smart contract.

contract Devapp {
    using Counters for Counters.Counter;

    Counters.Counter public _voterId;
    Counters.Counter public _candidateId;

    address public votingOrganizer;

    ///Candidate Details
    struct Candidate {
        uint256 candidateId;
        string age;
        string name;
        string image;
        uint256 voteCount;
        address _address;
        string ipfs;
    }


    event Candidate_create_fx(
        uint256 indexed candidateId,
        string age,
        string name,
        string image,
        uint256 voteCount,
        address _address,
        string ipfs
    );

    address[] public candidateAddress;

    mapping(address => Candidate) public candidates;

    //Voter Details

    address[] public votedVoters;

    address[] public votersAddress;
    mapping(address => Voter) public voters;

    struct Voter {
        uint256 voter_voterId;
        string voter_name;
        string voter_image;
        address voter_address;
        uint256 voter_allowed;
        bool voter_voted;
        uint256 voter_vote;
        string voter_ipfs;
    }

    event Voter_create_fx(
        uint256 indexed voter_voterId,
        string voter_name,
        string voter_image,
        address voter_address,
        uint256 voter_allowed,
        bool voter_voted,
        uint256 voter_vote,
        string voter_ipfs
    );

    //Voters Requirement 

    constructor() {
        votingOrganizer = msg.sender;
    }

    function setCandidate( //allows the contract's "votingOrganizer" to set a new candidate,
                            //by creating a new candidate struct and assigning values to its properties.
        address _address,
        string memory _age,
        string memory _name,
        string memory _image,
        string memory _ipfs
    ) public {
        require(
            votingOrganizer == msg.sender,
            "You have no azuthorization to set Candidate"
        );

        _candidateId.increment();

        uint256 idNumber = _candidateId.current();

        Candidate storage candidate = candidates[_address];

        candidate.age = _age;
        candidate.name = _name;
        candidate.candidateId = idNumber;
        candidate.image = _image;
        candidate.voteCount = 0;
        candidate._address = _address;
        candidate.ipfs = _ipfs;

        candidateAddress.push(_address);

        emit Candidate_create_fx(
            candidate.candidateId,
            _age,
            _name,
            _image,
            candidate.voteCount,
            candidate._address,
            candidate.ipfs
        );
    }

    function getCandidate() public view returns (address[] memory) { //returns an array of candidate addresses.
        return candidateAddress;
    }

    function getCandidateLength() public view returns (uint256) { //returns the length of the candidate address array.
        return candidateAddress.length;
    }

    function getCandidateData(address _address) //returns various information about a candidate, given an address.
        public
        view
        returns (
            string memory,
            string memory,
            uint256,
            string memory,
            uint256,
            string memory,
            address
        )
    {
        return (
            candidates[_address].age,
            candidates[_address].name,
            candidates[_address].candidateId,
            candidates[_address].image,
            candidates[_address].voteCount,
            candidates[_address].ipfs,
            candidates[_address]._address
        );
    }

    

    function voterRight( //allows the "votingOrganizer" to provide voting rights
                          //to a specific address (by creating a new voter struct and assigning values to its properties).
        address _address,
        string memory _name,
        string memory _image,
        string memory _ipfs
    ) public {
        require(
            votingOrganizer == msg.sender,
            "Ops! Only the authorizer can perform this operation."
        );

        _voterId.increment();

        uint256 idNumber = _voterId.current();

        Voter storage voter = voters[_address];

        require(voter.voter_allowed == 0);

        voter.voter_allowed = 1;
        voter.voter_name = _name;
        voter.voter_image = _image;
        voter.voter_address = _address;
        voter.voter_voterId = idNumber;
        voter.voter_vote = 1000;
        voter.voter_voted = false;
        voter.voter_ipfs = _ipfs;

        votersAddress.push(_address);

        emit Voter_create_fx(
            voter.voter_voterId,
            _name,
            _image,
            _address,
            voter.voter_allowed,
            voter.voter_voted,
            voter.voter_vote,
            voter.voter_ipfs
        );
        // }
    }

    function vote(address _candidateAddress, uint256 _candidateVoteId)
        external
    {
        Voter storage voter = voters[msg.sender];

        require(!voter.voter_voted, "You can't vote twice.");
        require(voter.voter_allowed != 0, "You can't vote twice.");

        voter.voter_voted = true;
        voter.voter_vote = _candidateVoteId;

        votedVoters.push(msg.sender);

        candidates[_candidateAddress].voteCount += voter.voter_allowed;
    }

    function getVoterLength() public view returns (uint256) {
        return votersAddress.length;
    }

    function getVoterData(address _address)
        public
        view
        returns (
            uint256,
            string memory,
            string memory,
            address,
            string memory,
            uint256,
            bool
        )
    {
        return (
            voters[_address].voter_voterId,
            voters[_address].voter_name,
            voters[_address].voter_image,
            voters[_address].voter_address,
            voters[_address].voter_ipfs,
            voters[_address].voter_allowed,
            voters[_address].voter_voted
        );
    }

    function getVotedVotersList() public view returns (address[] memory) {
        return votedVoters;
    }

    function getVoterList() public view returns (address[] memory) {
        return votersAddress;
    }

    bool public electionActive;


enum ElectionState { NotStarted, Started, Ended }
ElectionState public state;
// Code to start the election
function startElection() public {
    require(
        msg.sender == votingOrganizer,
        "You have no authorization to start the election"
    );
    require(state == ElectionState.NotStarted, "Election has already started.");
    state = ElectionState.Started;
    
}

}


