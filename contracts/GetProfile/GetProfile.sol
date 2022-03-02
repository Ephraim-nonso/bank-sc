//SPDX-License-Identifier: Unlicensed

pragma solidity 0.8.12;

contract GetProfile {
    struct Office {
        string officeName;
        string[] nameOfUsers;
        mapping(string => User) users;
    }

    struct OfficeV2 {
        string officeName;
        string[] nameOfUsers;
    }

    struct User {
        string name;
        uint256 id;
        address addr;
        string userOffice;
    }

    mapping(string => Office) private offices;

    // Functions to add offices and users.
    function createOffice(string calldata _officeName) external {
        Office storage o = offices[_officeName];
        o.officeName = _officeName;
    }

    function addUser(User memory _u, string calldata _on) external view {
        User memory u = offices[_on].users[_u.name];
        u.name = _u.name;
        u.id = _u.id;
        u.addr = _u.addr;
    }

    // The functions below help in getting individual office and user.
    function getOffice(string calldata _on)
        external
        view
        returns (OfficeV2 memory ov)
    {
        Office storage o = offices[_on];
        ov.officeName = o.officeName;
        ov.nameOfUsers = o.nameOfUsers;
    }

    function getUser(string calldata o, string calldata u)
        external
        view
        returns (User memory _u)
    {
        _u = offices[o].users[u];
    }

}
