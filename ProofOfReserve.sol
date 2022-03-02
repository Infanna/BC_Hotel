// SPDX-License-Identifier: MIT
pragma solidity ^0.8.1;

contract ProofOfStudent {  

  mapping (bytes32 => bool) private listStudent;

  //---events---
  event NameAdded(
    address from,   
    string text,
    bytes32 hash
  );
  
  event RegistrationError(
    address from,
    string text,
    string reason
  );

  // store the proof for a student in the contract state
  function recordProof(bytes32 proof) private {
    listStudent[proof] = true;
  }
  
  // record a student name
  function registration(string memory name) public payable {
    
    //---check if string was previously stored---
    if (listStudent[hashing(name)]) {
        //---fire the event---
        emit RegistrationError(msg.sender, name, "This room has been reserved.");
        //---refund back to the sender---
        payable(msg.sender).transfer(msg.value);
        //---exit the function---
        return;
    }



    if(keccak256(bytes(name)) == keccak256(bytes("villa1"))) {
        if (msg.value != 0.01 ether) {
            //---fire the event---
            emit RegistrationError(msg.sender, name, "Incorrect amout of Ether. You should pay 0.01 ether");
            //---refund back to the sender---
            payable(msg.sender).transfer(msg.value);
            //---exit the function---
            return;
        } 

    }else if(keccak256(bytes(name)) == keccak256(bytes("villa2"))){
        if (msg.value != 0.02 ether) {
            emit RegistrationError(msg.sender, name, "Incorrect amout of Ether. You should pay 0.02 ether");
            payable(msg.sender).transfer(msg.value);
            return;
        }     

    }else if(keccak256(bytes(name)) == keccak256(bytes("villa3"))){
        if (msg.value != 0.03 ether) {
            emit RegistrationError(msg.sender, name, "Incorrect amout of Ether. You should pay 0.03 ether");
            payable(msg.sender).transfer(msg.value);
            return;
        }     

    }else if(keccak256(bytes(name)) == keccak256(bytes("villa4"))){
        if (msg.value != 0.03 ether) {
            emit RegistrationError(msg.sender, name, "Incorrect amout of Ether. You should pay 0.03 ether");
            payable(msg.sender).transfer(msg.value);
            return;
        }     

    }else if(keccak256(bytes(name)) == keccak256(bytes("villa5"))){
        if (msg.value != 0.05 ether) {
            emit RegistrationError(msg.sender, name, "Incorrect amout of Ether. You should pay 0.05 ether");
            payable(msg.sender).transfer(msg.value);
            return;
        }

    }else if(keccak256(bytes(name)) == keccak256(bytes("villa6"))){
        if (msg.value != 10 ether) {
            emit RegistrationError(msg.sender, name, "Incorrect amout of Ether. You should pay 10 ether");
            payable(msg.sender).transfer(msg.value);
            return;
        }

    }else{
        emit RegistrationError(msg.sender, name, "Room not found, please contact staff");
        payable(msg.sender).transfer(msg.value);
        return;
    }
    //---check if msg.value != 0.001 ether---

    recordProof(hashing(name));
    
    //---fire the event---
    emit NameAdded(msg.sender, name, 
        hashing(name));
    
  }
  
  // SHA256 for Integrity
  function hashing(string memory name) private 
  pure returns (bytes32) {
    return sha256(bytes(name));
  }
  
  // check name of student in this class
  function checkName(string memory name) public 
  view returns (bool) {
    return listStudent[hashing(name)];
  }

  
}