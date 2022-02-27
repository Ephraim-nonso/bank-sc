//SPDX-License-Identifier: Unlicensed;

pragma solidity 0.8.6;

contract SchoolsDB {
    struct School {
        string name;
        string uniformColor;
        uint numOfStudents;
        mapping(address => bool) registered;
    }
    mapping(string => School) schools;

    struct SchoolWithoutMapping {
        string name;
        string uniformColor;
    }

    function addSchool(string calldata _name, string calldata _uniformColor) external {
        School storage s = schools[_name];
        s.name = _name;
        s.uniformColor = _uniformColor;
        s.registered[msg.sender] = true;
    }

    //function gets a single registered school.
    function allRegisteredSch (string memory _schs) external view returns(SchoolWithoutMapping memory s) {      
            School storage _s = schools[_schs];
            s.name = _s.name;
            s.uniformColor = _s.uniformColor;  
    } 

    // function retruns a collection of the registered schools.
    function allRegisteredSch (string[] memory _schs) external view returns(SchoolWithoutMapping[] memory s) {
        s = new SchoolWithoutMapping[](_schs.length);
        for(uint i = 0; i < _schs.length; i++) {
            School storage _s = schools[_schs[i]];
            s[i].name = _s.name;
            s[i].uniformColor = _s.uniformColor; 
        }
    } 
}
