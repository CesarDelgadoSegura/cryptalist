// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./safemath.sol";

contract ACLToken {
    using SafeMath for uint;

    string public name = "Adventure Cryptalist Lime Token";
    string public symbol = "ACLT";
    uint256 public totalSupply = 21000000;
    address private tokenAddr = address(0xAc40c9C8dADE7B9CF37aEBb49Ab49485eBD3510d);

    mapping(address => uint256) balanceOf;
    mapping(address => mapping(address => uint256)) public allowance;

    constructor() {
        balanceOf[tokenAddr] = totalSupply;
    }

    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);

    function transfer(address _to, uint256 _value) public returns(bool success){
        require(balanceOf[msg.sender] >= _value, "You don't have that amount.");
        balanceOf[msg.sender] = balanceOf[msg.sender].sub(_value);
        balanceOf[_to] = balanceOf[_to].add(_value);
        emit Transfer(msg.sender, _to, _value);
        return true;
    }

    function approve(address _spender, uint256 _value) public returns(bool success) {
        allowance[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
        return true;
    }
}
