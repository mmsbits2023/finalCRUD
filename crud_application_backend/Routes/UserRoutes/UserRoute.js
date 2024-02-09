const userController = require('../../Controller/UserController');
const userSchema = require('../../Schemas/UserSchema');
const universalFunction=require('../../Functions/universalFunction');
const validationFunction = require("../../Functions/validationFunction");
const Router = require("express").Router();

//signup user API
Router.route('/signup').post(
    validationFunction.validateUser(userSchema.userLoginSchema),
    userController.signupUser
 );


//login user API
Router.route('/login').post(
    validationFunction.validateUser(userSchema.userLoginSchema),
    userController.loginUser
 );

//Add user API
Router.route('/add/:id').put(
    universalFunction.authenticateUser,
   //validationFunction.validateUser(userSchema.userCreateSchema),
   userController.updatePhoneNumber
);

//update  user  all details API
Router.route('/update/:id').put(
    universalFunction.authenticateUser,
   //validationFunction.validateUser(userSchema.userCreateSchema),
   userController.updateUserDetails
);
//Get All User Details
Router.route('/getAllUserDetails').get(
    universalFunction.authenticateUser,
   // validationFunction.validateUser(userSchema.getAllUserSchemas),
    userController.getAllUserList
);


//Get One User Details
Router.route('/getOneUserDetails/:id').get(
    universalFunction.authenticateUser,
    //validationFunction.validateUser(userSchema.updateUserSchemas),
    userController.getOneUserDetails
);

//Delete One User Details
Router.route('/deleteUserDetails/:id').delete(
    universalFunction.authenticateUser,
    //validationFunction.validateUser(userSchema.updateUserSchemas),
    userController.deleteUser
);


exports.Router=Router;
















