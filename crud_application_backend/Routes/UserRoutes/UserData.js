const userController = require('../../Controller/UserTableController');
const userSchema = require('../../Schemas/UserSchema');
const universalFunction=require('../../Functions/universalFunction');
const validationFunction = require("../../Functions/validationFunction");
const Router = require("express").Router();

//save user  data API
Router.route('/save').post(
    validationFunction.validateUser(userSchema.saveUserDataSchema),
    userController.saveUserData
 );

//Get All User data
Router.route('/getAllUserData').get(
    universalFunction.authenticateUser,
   // validationFunction.validateUser(userSchema.saveUserDataSchema),
    userController.getAllUserDataList
);



exports.Router=Router;
















