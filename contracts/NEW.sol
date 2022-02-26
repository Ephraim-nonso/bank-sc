// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.6;

contract goodsExistence{

    struct Demand{
        string __name;
        uint qty;
        mapping(uint => address) customersAddress;
    }
    struct goodsDetails{
        string name;
        uint amount;
        string[] sizes;
        mapping(uint => string) supplier;
        Demand customer; 
    }

    struct DemandWithoutMapping{
        string __name;
        uint qty;
    }   
    struct structWithoutMApping{
        string name;
        uint amount;
        string[] sizes;
        DemandWithoutMapping cust;

    }

    uint Id = 1;

    
     mapping(string=>goodsDetails) private Goods;

     function addGoods(string memory _name, 
    
     uint _amount,
      string[] memory _size,
      string memory position,
      uint _qty, address addr, string memory _customer)
    
      public{
        goodsDetails storage request = Goods[position];
        request.name =_name;
        request.amount = _amount * _qty;
        request.sizes= _size;
        request.supplier[(Id + 100)]= position;
        request.customer.__name = _customer;
        request.customer.qty = _qty ;
        request.customer.customersAddress[(Id+500)] = addr;
        Id++;

    }

    function getCustomersAddress(string memory _position, uint _id) external view returns(address){
        return Goods[_position].customer.customersAddress[_id];
        
    }
    function checkProduct(string memory _position) external view returns(structWithoutMApping memory SWM){
        goodsDetails storage GD = Goods[_position];
        SWM.name = GD.name;
        SWM.amount = GD.amount;
        SWM.sizes = GD.sizes;
        SWM.cust.__name = GD.customer.__name;
        SWM.cust.qty = GD.customer.qty; 
    }


    
}