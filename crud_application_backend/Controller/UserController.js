const UserDetails = require("../Models/UserDetails");
const universalFunction = require('../Functions/universalFunction');
const crypto = require("crypto");
const jwt = require("jsonwebtoken");
const secretyKey = "abcdefghijklmnopqrstuvwxyzabcdef";


exports.signupUser = (async (request, response, next) => {
    try {
        
        const {
            userName,
            email,
            mpin,
            phoneNumber
           
        } = request.body;
        
        const userData = await UserDetails.find({ email:email }).countDocuments();
        if (userData > 0) {
            return response.status(409).send({
                status: "FAILURE",
                message: "User  already exist"
            })
        }
                                  
      
        const userDetailsCheck = new UserDetails();
        userDetailsCheck.userName = userName;
        userDetailsCheck.email = email;
       userDetailsCheck.password = mpin;
       userDetailsCheck.phoneNumber='';
        
        console.log("userDetails", userDetailsCheck);
       
        const userdetails = userDetailsCheck.save(async function (error, saveResult) {
            if (error) { throw new Error(error); }
  
            
            let responseData = {
                status: "SUCCESS",
                message: "User signup successfully",
                data: []
                            
            }; universalFunction.sendResponse(request, response, responseData, next);
            }
   
        );
        
        
    } catch (error) {
        console.log(error);
        next(error);
        
       
    }

});

exports.loginUser= async function (request, response, next) {
    try {
        const { email,userName,mpin} = request.body;
        const userData = await UserDetails.find({email:email})

        if (userData.length==0) {
            return response.status(400).send({
                status: "FAILURE",
                message: " Invalid data "
            })
        }
       // const user = userData[0];
        //if (!user || !user.authenticate(mpin)) {
        if (!userData[0].authenticate(mpin)) {
            let responseData = {
                status: "FAILURE",
                message: "Invalid Mpin",
                data: { verified: false }
            };
            universalFunction.sendResponse(request,response, responseData, next);
        } else {
            const salt = crypto.randomBytes(16).toString("hex");
            userData[0].authToken = salt;

            userData[0].save(async (error, result) => {
                if (error) {
                    throw new Error(error);
                }
                var jsonPayload = {
                    userName: userName,
                    email: email,
                    mpin:mpin
                    
                };
                const jwtData = jwt.sign(jsonPayload, `${secretyKey}-${salt}`, {
                    expiresIn: "1d",
                });
                
               console.log("jwtData",jwtData)

                let responseData = {
                    status: "SUCCESS",
                    message: "Login successfully",
                    data: {
                        verified: "true",
                        _id: userData[0]._id ,
                        userName:userName,
                        email:email,
                        authToken: jwtData,
                    },
                };
                universalFunction.sendResponse(request, response, responseData, next);
           
            })
        }

    } catch (error) {
        next(error);
    }

};
exports.updatePhoneNumber = async function (request, response, next) {
    try {
        const id = request.params.id;
        const { phoneNumber } = request.body;

        // Find the user by id and update the phoneNumber
        const updatedUser = await UserDetails.findOneAndUpdate(
            { _id: id },
            { $set: { phoneNumber: phoneNumber } },
            { new: true } // Return the updated document
        );

        if (!updatedUser) {
            return response.status(404).send({
                status: "FAILURE",
                message: "User not found"
            });
        }

        let responseData = {
            status: "SUCCESS",
            message: "Phone number added successfully",
            data: updatedUser
        };

        universalFunction.sendResponse(request, response, responseData, next);

    } catch (error) {
        console.log(error);
        next(error);
    }
};


  exports.getAllUserList = async function (request, response, next) {
    try {
        var userDetailsList = await UserDetails.find();

        if (userDetailsList.length === 0) {
            return response.status(400).send({
                status: "FAILURE",
                message: "User data not found"
            });
        }

        let responseData = {
            status: "SUCCESS",
            message: "List of all user",
            data: {
                userDetailsList: userDetailsList,
                count: userDetailsList.length,
            },
        };

        // Ensure that the response data is always an array
        responseData.data.userDetailsList = userDetailsList;

        universalFunction.sendResponse(request, response, responseData, next);

    } catch (error) {
        next(error);
    }
};

  exports.getOneUserDetails=async function (request,response,next){
    try{
         const userId=request.params.id;   
      
         const userDetails= await UserDetails.findById(userId);
           
        if (!userDetails)
       {
        return response.status(404).send({
            status:"FAILURE",
            message:" User data not  found"
        }); 
        }
        console.log("User...data", userDetails);
       let responseData={
        status:"SUCCESS",
        message:"Get one user details",
        data:userDetails
     }
     universalFunction.sendResponse(request,response,responseData,next);

    }catch(error){
        next(error);
    }
  };
  
 
exports.updateUserDetails = async function (request, response, next) {
    try {
        const id = request.params.id;
        const { phoneNumber,email,userName } = request.body;

        // Find the user by id and update the phoneNumber
        const updatedUser = await UserDetails.findOneAndUpdate(
            { _id: id },
            { $set: { phoneNumber: phoneNumber ,email:email,userName:userName} },
            { new: true } // Return the updated document
        );

        if (!updatedUser) {
            return response.status(404).send({
                status: "FAILURE",
                message: "User not found"
            });
        }

        let responseData = {
            status: "SUCCESS",
            message: "User data updated successfully",
            data: updatedUser
        };

        universalFunction.sendResponse(request, response, responseData, next);

    } catch (error) {
        console.log(error);
        next(error);
    }
};

  exports.deleteUser=async function(request,response,next){
    try{
      const userId=request.params.id;
                
       const userDetails=await UserDetails.findByIdAndDelete(userId);
        console.log(userDetails);   

         if(!userDetails){
        return response.status(400).send({
            status:"FAILURE",
            message:" User data not  found"
        }); 
        }
         
        //const userData = await UserDetails();    
         
       // agentData.phoneNumber = phoneNumber;

        let responseData = {
            status:"SUCCESS",
            message:"Delete user details successfully",
            data:[]
        }
        universalFunction.sendResponse(request,response,responseData,next);
  
    }catch(error)
    {
        next(error);
    }
  };