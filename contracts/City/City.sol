//SPDX-License-Identifier: MIT

pragma solidity 0.8.5;

contract City {

    struct City {
        uint district;
        string[] districtNames;
        uint[] zipCodes;
        string governor;
        Villages v;
    }

    struct CityWithout {
        uint district;
        string[] districtNames;
        uint[] zipCodes;
        string governor;
    }

    struct Villages {
        uint village;
        string towns;
        mapping(address => uint) houses;
        County oneCounty;
    }

    struct VillagesWithoutMapping {
        uint village;
        string towns;
    }
    struct County {
        uint district;
        string governor;
        mapping(address => uint) cottages;
    }


    mapping(string => City) cities;

    function addCity(uint _d, string[] memory _dn, uint[] memory _zc, string calldata _g, string calldata cityName) external {
        City storage c = cities[cityName];
        c.district = _d;
        c.districtNames = _dn;
        c.zipCodes = _zc;
        c.governor = _g;
    }

//Using the creation of a new struct
    function seeCities(string[] calldata _cn) external returns(City[] memory cOut_) {
        // City[] memory cc = new City[](_cn.length);
        for(uint i = 0; _cn.length; i++) {
            cOut_[i] = cities[_cn[i]];
        }
    }

// This is to avoid overflow of the output when getting it.
    function seeCities(string[] calldata _cn) external returns(City[3] memory cOut_) {
        for(uint i = 0; _cn.length; i++) {
            cOut_[i] = cities[_cn[i]];
        }
    }

    function getCottage(address cot, string memory _cn) external returns(uint c) {
        c = City.cities[_cn].v.oneCounty.cottages[cot];
    }

    function getVillage(address _village, string memory _name) external returns(Village[] memory v) {
        v.village = cities[_name].v.village;
        v.towns = cities[_name].v.towns;
        return v;
    }
}