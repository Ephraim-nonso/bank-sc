//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract ProofOfExistence {
    // State variables of the contract.
    struct studentRecord {
        uint ID;
        string fullName;
        uint DOB;
        string gender;
        string state_of_origin;
    }
    studentRecord[] public students;

    mapping(address => uint) private studentsID;
    mapping(uint => studentRecord) internal idToStudentProfile;
    mapping(uint => studentRecord) internal dropouts;
    uint ID = 1000;
    address admin;

    // This sets the admin at run time - point of deployment.
    constructor(address _admin) {
        admin = _admin;
    }

    // A modifier that gives the admin the power to carry out some functions.
    modifier onlyAdmin {
        require(msg.sender == admin, "Only admin can carry out this action.");
        _;
    }

    // This function can be carried out by the admin to add new students to the records.
    function addStudents(
        address _address,
        string memory _fullName, 
        uint _DOB, 
        string memory _gender,
        string memory _state_of_origin
        ) public onlyAdmin returns(bool success, uint) {
            // require((studentsID[_address] == 0),"This student already exist.");
            if(addressExist(_address)) {
                // revert("Student already exist");
                return (false, studentsID[_address]);
            }
            ID += 1;

        studentRecord memory newStudent = studentRecord(ID, _fullName, _DOB, _gender, _state_of_origin);
        students.push(newStudent);
        studentsID[_address] = ID;
        idToStudentProfile[ID] = newStudent;
            return (true, ID);
    }

    // This function can be called by students to enable them access their id via their addresses.
    function retrieveID() external view returns(bool, uint) {
        uint id = studentsID[msg.sender];
        if (id == 0) return (false, 0);
        return (true, id);
    }

    // This function can only be carried out by the admin to recover a student id through their address
    function adminRecovery(address _address) onlyAdmin external view returns(bool, uint) {
        uint id = studentsID[_address];
        if (id == 0) return (false, 0);
        return (true, id);
    }

    // Verifies that the students profile exist through their record id.
    function confirmRecord(uint _id) external view returns(studentRecord memory) {
        return idToStudentProfile[_id];
    }

    
    // This verifies the existennce of an address but not visible to be called outside the contract
    function addressExist(address _address) internal view returns(bool) {
        return !(studentsID[_address] == 0);
    }

    // This is for a student who wants to drop out.
    function dropOut(uint idToBeDeleted) external onlyAdmin returns(bool) {
        require(idToStudentProfile[idToBeDeleted].ID != 0, "Student does not exist");
        dropouts[idToBeDeleted] = idToStudentProfile[idToBeDeleted];
        delete idToStudentProfile[idToBeDeleted];

        // First method:
        // for(uint i; i < students.length; i++) {
        //     if(students[i].ID == idToBeDeleted) {
        //         delete students[i];
        //     }
        // }

        // Second method
        // uint indexToBeRemoved;
        // for(uint i; i < students.length; i++) {
        //     if(students[i].ID == idToBeDeleted) {
        //         indexToBeRemoved = i;
        //         // delete students[indexToBeRemoved];
        //         break;
        //     }
        // }

        // for(uint i = indexToBeRemoved; i < students.length - 1; i++) {
        //     students[i] = students[i + 1];
        // }

        // students.pop();

        // Third method
        uint indexToBeRemoved;
        for(uint i; i < students.length; i++) {
            if(students[i].ID == idToBeDeleted) {
                indexToBeRemoved = i;
                break;
            }
        }
        students[indexToBeRemoved] = students[students.length -1];
        students.pop();
        return true;
    }
}