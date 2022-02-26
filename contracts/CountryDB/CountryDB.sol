//SPDX-License-Identifier: MIT

pragma solidity 0.8.6;

contract CountryDB {

    struct Village {
        string[] elderStatemen;
        uint[] communityContribution;
        string[] availableSchools;
        // mapping(string => uint) members;
    }   

    struct LGA {
        string lgaName;
        string Chairman;
        uint Revenue;
        string[] markets;
        mapping(string => Village) villages;
    }

    struct LGAWithoutMapping {
        string lgaName;
        string Chairman;
        uint Revenue;
        string[] markets;
        Village _villa;
    }

    struct State {
        string stateName;
        string governor;
        string capital;
        uint[] zipCodes;
        uint IGR;
        mapping(string => LGA) LGAs;
    }

    struct StateWithoutmapping {
        string stateName;
        string governor;
        string capital;
        uint[] zipCodes;
        uint IGR;
    }

    /*@Dev
    *This is a struct of the Country
    *with a mapping.
    */
    struct Country {
        string countryName;
        string president;
        string capital;
        uint GDP;
        uint countryRevenue;
        mapping(string => State) states;
    }

    mapping(string => Country) countries;

    /*@Dev
    *This is a struct of the Country
    *without a mapping. To aid in the display
    *of the country.
    */
    struct CountryWithoutStates {
        string countryName;
        string president;
        string capital;
        uint GDP;
        uint countryRevenue;
    }

    /*@dev
    The three function adds new country, state
    and a LGA
    */

    function addCountry(
        string calldata _cn, 
        string calldata _p,
        string calldata _c,
        uint _gdp,
        uint _cR
        ) external {
        Country storage c = countries[_cn];
        c.countryName = _cn;
        c.president = _p;
        c.capital = _c;
        c.GDP = _gdp;
        c.countryRevenue = _cR;
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
        state.stateName = _state;
        state.governor = _governor;
        state.capital = _capital;
        state.zipCodes = _zipCodes;
        state.IGR = _IGR;
    }

    function addLGA(
        string calldata _cn,
        string calldata _st,
        string calldata _lg,
        string calldata _chairman,
        uint _Revenue,
        string[] memory _markets
    ) external {
       LGA storage lga = countries[_cn].states[_st].LGAs[_lg];
        lga.lgaName = _lg;
        lga.Chairman = _chairman;
        lga.Revenue= _Revenue;
        lga.markets = _markets;
    }

    function addVillage(
        string calldata _cn,
        string calldata _st,
        string calldata _lg,
        string calldata _v,
        string[] memory _elders,
        uint[] memory _cmc,
        string[] memory _ass
    ) external {
       Village storage vi = countries[_cn].states[_st].LGAs[_lg].villages[_v];
       vi.elderStatemen = _elders;
       vi.communityContribution = _cmc;
       vi.availableSchools = _ass; 
    }

    //see a single country.
    function seeCountry(string calldata _cn) external view returns(CountryWithoutStates memory c) {
        Country storage singleCountry = countries[_cn];
        c.countryName = singleCountry.countryName;
        c.president = singleCountry.president;
        c.capital = singleCountry.capital;
        c.GDP = singleCountry.GDP;
        c.countryRevenue = singleCountry.countryRevenue;
    }

    //view a single state
    function seeState(string calldata _st, string calldata _c) external view returns (StateWithoutmapping memory s) {
        State storage state = countries[_c].states[_st];
        s.stateName = state.stateName;
        s.governor = state.governor;
        s.capital = state.capital;
        s.zipCodes = state.zipCodes;
        s.IGR = state.IGR;
    }

    //See a single LGA.
    function seeLGA(string calldata _lg,
    string calldata _st,
    string calldata _cn
    ) view public returns (LGAWithoutMapping memory lg) {
        LGA storage lgReplica = countries[_cn].states[_st].LGAs[_lg];
        lg.lgaName = lgReplica.lgaName;
        lg.Chairman = lgReplica.Chairman;
        lg.Revenue = lgReplica.Revenue;
        lg.markets = lgReplica.markets;
    }
    
    function seeAllCountries(string[] memory _cn) external
     view returns(CountryWithoutStates[] memory c) {
        c = new CountryWithoutStates[](_cn.length);
        for(uint i = 0; i < _cn.length; i++) {
        Country storage cii = countries[_cn[i]];
            c[i].countryName= cii.countryName;
            c[i].president= cii.president;
            c[i].capital= cii.capital;
            c[i].GDP= cii.GDP;
            c[i].countryRevenue= cii.countryRevenue;
        }
    }

    function seeAllStatesInCountry(
        string memory _cn,
        string[] memory _st
    ) external view returns(StateWithoutmapping[] memory st) {
        st = new StateWithoutmapping[](_st.length);
        for(uint i = 0; i < _st.length; i++) {
            State storage _ostate = countries[_cn].states[_st[i]];
            st[i].stateName = _ostate.stateName;
            st[i].governor = _ostate.governor;
            st[i].capital = _ostate.capital;
            st[i].zipCodes = _ostate.zipCodes;
            st[i].IGR = _ostate.IGR;
        }
    }
}
