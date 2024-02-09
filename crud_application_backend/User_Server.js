require('./db/connection');
const cors = require("cors");
const path = require("path");
const express = require("express");
const app = express();
const Port = process.env.PORT || 9000;
const userRouter = require('./Routes/UserRoutes/UserRoute');
const userTableRouter = require('./Routes/UserRoutes/UserData');

const bodyParser = require('body-parser');

app.use(express.json());
app.use(express.urlencoded({extended:false}));
app.use(cors());
app.use(bodyParser.urlencoded({ extended: false }));



app.use('/user', userRouter.Router);
app.use('/userTable', userTableRouter.Router);





app.listen(Port, () => { 
    console.log(`Server is running on port number ${Port}`)
})