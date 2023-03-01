<<<<<<< HEAD
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/utils/Counters.sol"; // import Counters library from OpenZeppelin
import "hardhat/console.sol"; // import console library from Hardhat
=======
// MIT-License-Identifier:
pragma solidity ^0.8.9;


//* @ this is to import the dependencies required for some functions in this code
import "@openzeppelin/contracts/utils/Counters.sol";
import "hardhat/console.sol";
>>>>>>> 4e231b84afb0263b872a9674c0e9de1dc2ee20aa


// this contract is creates a list of candidates,
// and maps the details of each candidate sequentially,
// it also creates a list of  voters,
// and maps the details of each voter sequentially,

// the deployer's contract is attached as the authorizer and the authorizer can create
// add candidates and voters (only the authorizer will be able to perform these functions)
// the authorizer can also start the election and the election will end once the time's elapsed.


// Each voter can only vote once and have to connect with their wallet to interact with the smart contract.

contract Devapp {
    using Counters for Counters.Counter; // use Counters library to implement counters

    // State Variables
    Counters.Counter private _voterId; // counter to keep track of the number of voters
    Counters.Counter private _candidateId; // counter to keep track of the number of candidates
    address public authorizer; // public variable to store the contract authorizer's address
    address[] public candidateAddresses; // public array to store the addresses of all candidates
    address[] public voterAddresses; // public array to store the addresses of all voters
    uint256 public totalVotes;
    uint256 public endTime;
    bool public ended;
    bool public started;
    enum ElectionState { NotStarted, Started, Ended }
    ElectionState public state;


<<<<<<< HEAD
    // Structs
=======
    ///Candidate Details
>>>>>>> 4e231b84afb0263b872a9674c0e9de1dc2ee20aa
    struct Candidate {
        uint256 id; // unique identifier for candidate
        string age; // age of candidate
        string name; // name of candidate
        string image; // IPFS hash of candidate's image
        uint256 voteCount; // number of votes received by the candidate
        address addr; // address of the candidate
        string ipfs; // IPFS hash of candidate's information
    }

<<<<<<< HEAD
    struct Voter {
        uint256 id; // unique identifier for voter
        string name; // name of voter
        string image; // IPFS hash of voter's image
        address addr; // address of the voter
        uint256 voteCredits; // number of votes the voter can cast
        bool voted; // flag to indicate whether the voter has cast their votes or not
        uint256 voteIndex; // index of the candidate voted for by the voter
        // uint voterIndexConverted; // converts the initialized the signed index of a newly registered voter to an unsigned index to avoid compilation error while assigning it to the argument   
        string ipfs; // IPFS hash of voter's information
    }

    // Mappings
    mapping(address => Candidate) public candidates; // mapping to store candidate information based on their address
    mapping(address => Voter) public voters; // mapping to store voter information based on their address
    mapping(address => bool) public hasVoted; // mapping to keep track of whether a voter has voted or not

    // Events
    event CandidateCreated(
        uint256 indexed id,
=======

    event Candidate_create_fx(
        uint256 indexed candidateId,
>>>>>>> 4e231b84afb0263b872a9674c0e9de1dc2ee20aa
        string age,
        string name,
        string image,
        uint256 voteCount,
        address addr,
        string ipfs
<<<<<<< HEAD
    ); // event triggered when a candidate is created

    event VoterCreated(
        uint256 indexed id,
        string name,
        string image,
        address addr,
        uint256 voteCredits,
        bool voted,
        uint256 voteIndex,
        string ipfs
    ); // event triggered when a voter is created

    // Modifiers
    modifier onlyAuthorizer() {
        require(msg.sender == authorizer, "Only the contract authorizer can call this function."); // restrict function access to only the authorizer
        require(state == ElectionState.NotStarted, "Election has already started."); //restrict function accessible only if the election has not yet started
        require(state != ElectionState.Ended, "Election has already ended" );// restrict function accessible only if the election has not yet started and ended.
        _; // execute the function
=======
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
>>>>>>> 4e231b84afb0263b872a9674c0e9de1dc2ee20aa
    }

  
    // Constructor
    constructor() {
        authorizer = msg.sender; // set the contract authorizer's address as the sender of the constructor transaction
        state = ElectionState.NotStarted;
        
    }

    // Candidate Functions
    function createCandidate(
        address _addr,
        string memory _name,
        string memory _age,
        string memory _image,
        string memory _ipfs
    ) public onlyAuthorizer{
        _candidateId.increment(); // increment the candidate counter
        uint256 id_number = _candidateId.current(); // get the current value of the candidate counter

        Candidate storage candidate = candidates[_addr]; // create a reference to the candidate with the given address
        candidate.id = id_number; // set the candidate's id
        candidate.name = _name;
        candidate.age = _age;
        candidate.image = _image;
        candidate.voteCount = 0;
        candidate.addr = _addr;
        candidate.ipfs = _ipfs;

        candidateAddresses.push(_addr);

<<<<<<< HEAD
        emit CandidateCreated(
            candidate.id,
=======
        emit Candidate_create_fx(
            candidate.candidateId,
            _age,
>>>>>>> 4e231b84afb0263b872a9674c0e9de1dc2ee20aa
            _name,
            _age,
            _image,
            candidate.voteCount,
            candidate.addr,
            candidate.ipfs
            
        );
        
    }

    function getCandidateAddress() public view returns(address[] memory) {
        return candidateAddresses;
    }

    function getCandidateAddressesLength() public view returns (uint256) {
        return candidateAddresses.length;
    }

    function getCandidateDetails(address _address)
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
        Candidate memory candidate = candidates[_address];
        return (
            candidate.age,
            candidate.name,
            candidate.id,
            candidate.image,
            candidate.voteCount,
            candidate.ipfs,
            candidate.addr
        );
    }

<<<<<<< HEAD
        // Voters Functions
    function createVoters(
        address _addr,
=======
    

    function voterRight( //allows the "votingOrganizer" to provide voting rights
                          //to a specific address (by creating a new voter struct and assigning values to its properties).
        address _address,
>>>>>>> 4e231b84afb0263b872a9674c0e9de1dc2ee20aa
        string memory _name,
        string memory _image,
        string memory _ipfs
    ) public onlyAuthorizer{
        _voterId.increment();
<<<<<<< HEAD
        uint256 id = _voterId.current();
        Voter storage voter = voters[_addr];
        require(voter.voteCredits == 0, "This account already exists");
        voter.voteCredits = 1;
        voter.name = _name;
        voter.image = _image;
        voter.addr = _addr;
        voter.id = id;
        voter.voteIndex = 1000000000;
        voter.voted = false;
        voter.ipfs = _ipfs;
        voterAddresses.push(_addr);
        
    emit VoterCreated(
        voter.id,
        _name,
        _image,
        _addr,
        voter.voteCredits,
        voter.voted,
        voter.voteIndex, 
        voter.ipfs
    );
=======

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
>>>>>>> 4e231b84afb0263b872a9674c0e9de1dc2ee20aa

    }

    function voteBooth(address _candidateAddr, uint256 _candidateUniqueId) external onlyAuthorizer{
        Voter storage voter = voters[msg.sender];
        require(!voter.voted, "You can't vote twice." );
        require(voter.voteCredits != 0, "Your account isn't registered or authorized." );
        
        voter.voted = true;
        voter.voteIndex = _candidateUniqueId;
        voterAddresses.push(msg.sender);
        candidates[_candidateAddr].voteCount += voter.voteCredits;

        }

     function getVoterDetails(address _addr) public view returns (
         uint256,
         string memory,
         string memory,
         address,
         string memory,
         uint256,
         bool
     ){
         return(
             voters[_addr].id,
             voters[_addr].name,
             voters[_addr].image,
             voters[_addr].addr,
             voters[_addr].ipfs,
             voters[_addr].voteCredits,
             voters[_addr].voted


         );
     }

    function getVotersLength() public view returns (uint256) {
        return voterAddresses.length;
    }
    function get_voter_list() public view returns (address[] memory){
        return voterAddresses;
    }

    function commenceElection(bool) public onlyAuthorizer{
        state = ElectionState.Started;
        started == true;

        
        
    }
     
    function countdown() public view returns (uint256 _lapse){
        require (state == ElectionState.Started);
        _lapse = 8400;
         
        return _lapse;

        
        


    }

    function electionEnds() public view returns (string memory message ) {
        message = "The election has ended";
        require (state == ElectionState.Started);
        require(block.timestamp >= endTime);
        
        return message;
        
        
        
        
        
    }
       
    }

        