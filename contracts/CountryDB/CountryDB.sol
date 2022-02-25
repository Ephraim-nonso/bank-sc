//SPDX-License-Identifier: MIT

pragma solidity 0.8.6;

contract CountryDB {

    struct Village {
        string[] elderStatemen;
        uint[] communityContribution;
        string[] availableSchools;
    }

    struct LGA {
        string Chairman;
        uint Revenue;
        string[] markets;
        mapping(string => Village) villages;
    }

    struct State {
        string governor;
        string capital;
        uint[] zipCodes;
        uint IGR;
        mapping(string => LGA) LGAs;
    }

    struct StateWithoutmapping {
        string governor;
        string capital;
        uint[] zipCodes;
        uint IGR;
    }

    struct CountryWithoutStates {
        string president;
        string capital;
        uint GDP;
        uint countryRevenue;
    }

    struct Country {
        string president;
        string capital;
        uint GDP;
        uint countryRevenue;
        mapping(string => State) states;
    }

    mapping(string => Country) countries;

    function addCountry(
        string calldata _cn, 
        string calldata _p,
        string calldata _c,
        uint _gdp,
        uint _cR,
        string memory addstate
        ) external {
        Country storage c = countries[_cn];
        c.president = _p;
        c.capital = _c;
        c.GDP = _gdp;
        c.countryRevenue = _cR;
        c.states[addstate];
    }

    function addState(
        string calldata _state,
        string calldata _cn,
          string calldata _governor,
        string calldata _capital,
        uint[] memory _zipCodes,
        uint _IGR
    ) external {
        State storage state = countries[_cn].states[_state];
        // State storage state = country.states[_state];
        state.governor = _governor;
        state.capital = _capital;
        state.zipCodes = _zipCodes;
        state.IGR = _IGR;
    }

    // function addLGA(
    //     string calldata _lga;
    //     string calldata _cn,
    //       string calldata _governor;
    //     string calldata _capital;
    //     uint[] memory _zipCodes;
    //     uint _IGR;
    // ) external {
    //     Country storage country = contries[_cn];
    //     State storage state = country.states[_lga];
    //     state.governor = _governor;
    //     state.capital = _capital;
    //     state.zipCodes = _zipCodes;
    //     state.IGR = _IGR;
    // }

    //see a single country.
    function seeCountry(string calldata _cn) external view returns(CountryWithoutStates memory c) {
        Country storage singleCountry = countries[_cn];
        c.president = singleCountry.president;
        c.capital = singleCountry.capital;
        c.GDP = singleCountry.GDP;
        c.countryRevenue = singleCountry.countryRevenue;
    }

    //view a single state
    function seeState(string calldata _st, string calldata _c) external view returns (StateWithoutmapping memory s) {
        State storage state = countries[_c].states[_st];
        s.governor = state.governor;
        s.capital = state.capital;
        s.zipCodes = state.zipCodes;
        s.IGR = state.IGR;
    }
      
}