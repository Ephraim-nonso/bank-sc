//SPDX-License-Identifier: Unlicensed

pragma solidity 0.8.0;

contract Try {
    struct MyTime {
        bool paid;
    }

    MyTime public t;

    //function to change paid status
    function pay() external  returns(string memory x) {
        setTimeToPay();
        // assert(t.paid);
        x = "paid";
    }

    function setTimeToPay() internal {
        // t.paid = t.paid ? true : false;
        t.paid = !t.paid;

        // t.paid ? t.paid : !t.paid;
    }
}