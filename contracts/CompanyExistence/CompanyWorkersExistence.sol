//SPDX-License-Identifier: UNLINCENSED

pragma solidity ^0.8.6;

contract Partnership {
  
    /*
     * @Audience.
     * This is a partnership contract that restricts double registration of partners and CEOS.
     * The CEO and partners cannot be a worker.
     * The employment of a worker is carried out by the CEO and must require 
     an address of one of the partners.The same logic applies for the removal of a worker.
     * The owner and shareholders can always check existing workers' profile through their 
     unique worker id.
     * The worker can retrieve their profile through their worker id.
     */
  
    // Collection of state variables
    // 
    uint8 numOfApprovals;
    uint8 id;

    // The CEO's Address.
    address CEO;

    // The mapping variables
    mapping(address => bool) public partners;
    mapping(uint => Worker) private presentWorkers;
    mapping(address => bool) private AllWorkers;
    mapping(uint => Worker) private droppedWorkers;

    // The structs variables
    struct Worker {
        uint workerId;
        address workerAddress;
        string department;
        bool status;
    }

    // An array of the workers' profile.
    Worker[] workers;
   

    // The constructor receives the collection of parters into the contract.
    constructor(address[] memory _partners) {
        CEO = msg.sender;
        partners[CEO] = true;
        for(uint8 i; i < _partners.length; i++) {
        assert((partners[_partners[i]] == false));
        partners[_partners[i]] = true;
        }
    }

    //This modifier ensures that decision involves the CEO and one of the reciognized partners,
    // particulary to add and remove a worker.
    modifier onlyCEOAndPartners(address _onePartner) {
        require(CEO != _onePartner, "Provide another partner.");
        require(partners[_onePartner] == true, "Provide a true partner.");
        require(partners[msg.sender] == true, "You're not the CEO");
        require(partners[CEO] == true, "You're not the CEO");
        _;
    }

    //This modifier gives the partners the ability to call a function,
    // particularly to check the existence of a worker.
    modifier onlyCEO {
        require(partners[CEO] == true, "You're not obliged to carry out this function.");
        _;
    }


    //The function that adds a new worker.
    function addWorker(string memory _dept, address _workerAddress, address _onePartner) public onlyCEOAndPartners(_onePartner) returns(Worker memory) {
        require(AllWorkers[_workerAddress] == false, "You've employed this worker before.");
        require(AllWorkers[_workerAddress] == partners[_workerAddress], "Partners cannot be a worker");
        id += 1;
        Worker memory worker = Worker(id, _workerAddress, _dept, false);
        worker.status = true;
        presentWorkers[id] = worker;
        AllWorkers[_workerAddress] = true;
        workers.push(worker);
        return presentWorkers[id]; 
    }

    // The internal function that helps get the status of an employed worker.
    function checkPresentWorker(uint id_) internal view returns(bool) {
        return presentWorkers[id_].status;
    }

    // The function removes with any of the partners
    function removeWorker(uint _workerId, address _onePartner) external onlyCEOAndPartners(_onePartner) returns(bool) {
        require(workers[_workerId].workerId != 0, "Student does not exist");
        droppedWorkers[_workerId] = presentWorkers[_workerId];
        delete presentWorkers[_workerId];
        
        uint indexToBeRemoved;
        for(uint i; i < workers.length; i++) {
            if(workers[i].workerId == _workerId) {
                indexToBeRemoved = i;
                break;
            }
        }
        workers[indexToBeRemoved] = workers[workers.length -1];
        workers.pop();
        return true;
    }

    function getworkerProfile(uint8 workerID) external view returns(Worker memory, bool) {
        require(workerID != 0, "There is no worker with 0 id");
        require(workerID  == presentWorkers[id].workerId, "There is no worker with that id");
        return (presentWorkers[id], checkPresentWorker(workerID));
    }

    modifier onlyWorker(uint _workerID) {
        require(CEO == msg.sender, "You're not the worker.");
        _;
    }

    function retrieveAddress(uint8 _workerID) external view returns(address, string memory, uint) {
        return (workers[_workerID].workerAddress, workers[_workerID].department, workers[_workerID].workerId);
    }

}

