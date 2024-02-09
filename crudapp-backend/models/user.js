const mongoose = require("mongoose");
const express = require("express");
const passportLocalMongoose = require('passport-local-mongoose');

const userSchema = mongoose.Schema({
    username: {
        type:String
    },
    email: {
        type:String,
    },
    password: {
        type:String
    },
    phoneNumber:{
        type:Number 
    }
});

userSchema.plugin(passportLocalMongoose);

const user = mongoose.model("User",userSchema);

module.exports = user;