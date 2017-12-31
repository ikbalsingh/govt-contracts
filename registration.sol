pragma solidity ^0.4.0;

contract CitizenRegistration {
    event ErrorLogger(string);
    event AddCitizen(string);
    struct _Citizen{
        string _fullname;
        uint _dateofbirth;
        string _permanentAddress;
        bool _isACitizen;
    }
    _Citizen[] _Citizens;
    mapping (address => _Citizen) _validCitizens;

    function addCitizen  (string fullname,uint  dateofbirth , string permanentAddress)
    public returns (bool){
        if(_validCitizens[msg.sender]._isACitizen != true){
            _Citizen memory newCitizen = _Citizen(fullname,dateofbirth,permanentAddress,true);
            _validCitizens[msg.sender] = newCitizen;
             _Citizens.push(newCitizen);
            AddCitizen(_Citizens[_Citizens.length-1]._fullname);
            return true;
        }else{
            ErrorLogger("You cannot reister again");
        }
    }

    function getCitizenInfo(address id) public returns (string){
        return _validCitizens[id]._fullname;
    }
}

