const mongoose = require("mongoose");
const crypto = require("crypto");
const { v1: uuidv1 } = require("uuid");

const userSchemas = new mongoose.Schema({
    id:{
        type:String,
    },
    userName: {
        type: String,
              
    },
    displayName:{
        type:String,
    },
        password: {
        type:String
    },
  
   
})


module.exports=new mongoose.model("UserTable",userSchemas);