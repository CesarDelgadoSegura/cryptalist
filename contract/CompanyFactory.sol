// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CompanyFactory {
    uint cpyExponential = 64;
    uint cpyModulus = 10 ** cpyExponential;

    struct Company {
        string name;
        uint code;
        uint level;
        uint waittime;
    }

    Company[] internal companies; 

    mapping (uint => address) ownerToCompany;

    function _createCompany(string memory _name, uint _code) internal {
        companies.push(Company(_name, _code, 1, block.timestamp));
        uint id = (companies.length - 1);
        ownerToCompany[id] = msg.sender;
    }

    function _generateRandomCode(string memory _str) internal view returns(uint) {
        uint rand = uint(keccak256(abi.encode(_str)));
        return rand % cpyModulus;
    }

    function createRandomCompany(string memory _name) public {
        uint _code = _generateRandomCode(_name);
        _createCompany(_name, _code);
    }

    function getCompanies() public view returns(Company[] memory) {
        Company[] memory array = companies;
        return array;
    }
}
