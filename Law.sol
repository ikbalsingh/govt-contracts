pragma solidity ^0.4.11;
import "registration.sol";

contract Law{
    event log(uint);
    CitizenRegistration _citizenInfo =  CitizenRegistration(0xbbf289d846208c16edc8474705c748aff07732db);
    mapping (address => uint) _convictedCriminals;
    mapping(string => uint) _Constitution;

    function Law(){
        _Constitution["MURDER"] = 3;
        _Constitution["THEFT"] = 1;
        _Constitution["RAPE"] = 2;
    }
    function enforceLaw(string tag , address criminal) public returns(bool) {
        if(_convictedCriminals[criminal] == 0){
                if(_Constitution[tag] != 0){
                    _convictedCriminals[criminal] = _Constitution[tag];
                    return true;
                }else{
                    return false;
                }
        }else{
            return false;
        }
    }
}
