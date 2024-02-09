const UserTable = require("../Models/UserData");
const universalFunction = require('../Functions/universalFunction');



exports.saveUserData = (async (request, response, next) => {
    try {
        
        const {
            id,
            userName,
            displayName,
            password,
            
           
        } = request.body;
        
        const userData = await UserTable.find({id:id}).countDocuments();
        if (userData > 0) {
            return response.status(409).send({
                status: "FAILURE",
                message: "User  already exist"
            })
        }
                                  
      
        const userDetailsCheck = new UserTable();
        userDetailsCheck.id=id;
        userDetailsCheck.userName = userName;
        userDetailsCheck.displayName=displayName;
       userDetailsCheck.password = password;
     
        
        console.log("userDetails", userDetailsCheck);
       
        const userdetails = userDetailsCheck.save(async function (error, saveResult) {
            if (error) { throw new Error(error); }
  
            
            let responseData = {
                status: "SUCCESS",
                message: "User data save successfully",
                data: []
                            
            }; universalFunction.sendResponse(request, response, responseData, next);
            }
   
        );
        
        
    } catch (error) {
        console.log(error);
        next(error);
        
       
    }

});


exports.getAllUserDataList = async function (request, response, next) {
    try {
        var userDetailsList = await UserTable.find();

        if (userDetailsList.length === 0) {
            return response.status(400).send({
                status: "FAILURE",
                message: "User data not found"
            });
        }

        let responseData = {
            status: "SUCCESS",
            message: "List of all user data",
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
