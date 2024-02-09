
exports.userLoginSchema={
  type:"object",
  properties:{
      userName:{
          type:"string",
          
      },
      email:{
        type:"string",
        
    },
  
      mpin:{
          type:"string",
          minLength:6,
          maxLength:9,
               },
    
  },
  required: ["userName","mpin","email"]
};
exports.userCreateSchema={
    type:"object",
    properties:{
      phoneNumber: {
        type:String,
        minLength: 10,
        maxLength: 10,
        pattern: "^[0-9()-.s]+$",
    },
       
      
    },
    required: ["phoneNumber"]
};
exports.getAllUserSchemas = {

  type: "object",
  properties: {
    email: {
      type: "string",
      
    },
    
  },
  required: ["email"],
};
exports.getOneUserSchemas = {

  type: "object",
  properties: {
    email: {
      type: "string",
      
    },
    
  },
  required: ["email"],
};


exports.updateUserSchemas = {

  type: "object",
  properties: {
    email: {
      type: "string",
      
    },
    
  },
  required: ["email"],

};

exports.deleteUserSchemas = {
  type: "object",
  properties: {
    email: {
      type: "string",
      
    },
    
  },
  required: ["email"],
};

//----------------------

exports.saveUserDataSchema={
  type:"object",
  properties:{
    id:{
      type:"string",
      
      
  },
      userName:{
          type:"string",
          
      },
      displayName:{
        type:"string",
        
    },
      password:{
        type:"string",
        minLength:6,
        maxLength:20
        
    },
  
    
  },
  required: ["id","userName","displayName","password"]
};