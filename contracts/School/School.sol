//SPDEX-License-Identifier: Unlicensed

pragma solidity 0.8.4;

contract SchoolRegistry {
    struct Student {
        string favName;
        string[] uniform;
        uint[] items;
    }
    mapping(string => Student) students;

    function addStudent(string calldata name, string calldata _fN, string[] memory _u, uint[] memory _i) external {
        Student storage s = students[name];
        s.favName = _fN;
        s.uniform = _u;
        s.items = _i;
    }

    function checkStudents(string[] calldata name) external view returns(Student[] memory person) {
        person = new Student[](name.length);
        for(uint i = 0; i < name.length; i++) {
            person[i] = students[name[i]];
        }
    }

    function changeUniform(string[] memory _newUniform, string memory name) external {
        students[name].uniform = _newUniform;
    }
}