const user = require("../models/user.js");
const express = require("express");
const Router = express.Router();
const passport = require("passport");
const {isLoggedin} = require("../middleware.js");

Router.get("/",async (req,res) =>{
    let allUser = await user.find({});
    res.json({message:"All user",allUser});
});

Router.post("/signup",async (req,res) =>{
    let {
        username,email,password
    } = req.body;

    let user1 = new user({
       username , email 
    });

    try{
        const registeredUser = await user.register(user1, password);
        console.log(registeredUser);
        req.login(registeredUser,(err) =>{
            if(err){
               return err;
            }
            else{
                console.log("logged in after siggned up!!");
           }})
    }catch(error){
        console.log("error Registering user",error)
    }
});

Router.get("/login",(req,res) =>{
    res.send("Congrulations you are logged in !!!");
});

Router.post('/login', 
  passport.authenticate('local',{ failureRedirect: '/' }),
  function(req, res) {
    res.redirect('/user/login');
}
);

Router.post("/logout",(req,res) =>{
    req.logOut((err) =>{
        if(err){
            return err;
        }else{
            console.log("You are logged out!!"); 
        }
    })
});

Router.post("/show/:id",
isLoggedin,
async (req,res) =>{
  const {id} = req.params;
  const us = await user.findById(id);
  res.json({message:"Data",us});
});

Router.patch("/add/:id",async (req,res) =>{
    
    let {id} = req.params;

    let {phoneNumber} = req.body;

    let updateUser = await user.findByIdAndUpdate(id,{phoneNumber:phoneNumber});
  updateUser.phoneNumber=phoneNumber;      
    let result = await updateUser.save();
    res.json({message:"Data",result});
});

Router.patch("/update/:id",async (req,res) =>{
    
    let {id} = req.params;

    let {username,email,phoneNumber} = req.body;

    let updateUser = await user.findByIdAndUpdate(id,{username:username,email:email,phoneNumber:phoneNumber});
    let result = await updateUser.save();
    res.json({message:"Data",result});
});

Router.delete("/delete/:id",async (req,res) =>{

    let {id} = req.params;

    let deleteUser = await user.findByIdAndDelete(id);
    res.json({message:"deleted",deleteUser});
});

module.exports = Router;