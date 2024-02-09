require('dotenv').config()

const express = require("express");
const mongoose = require("mongoose");
const app = express();
const user = require("./models/user.js");
const userRouter = require("./routes/user.js");
const passport = require("passport");
const LocalStrategy = require("passport-local");
const session = require("express-session");
const MongoStore = require("connect-mongo");

app.use(express.json());

const DbUrl = process.env.MONGO_URL;

main()
.then(res => console.log("mongoose connected"))
.catch(err => console.log(err));

async function main() {
  await mongoose.connect(DbUrl);
}


const store = MongoStore.create({
  mongoUrl : DbUrl,
  crypto : {
      secret :process.env.SECRET
  },
});

store.on("error",() =>{
  console.log("error in mongo session store",err)
});

const sessionOption = {
  store,
  secret: process.env.SECRET ,
  resave : false , 
  saveUninitialized :true,
  cookie :{
      expires : Date.now() * 1 * 24 * 60 * 68 * 1000,
      maxAge :  7 * 24 * 60 * 68 * 1000,
      httpOnly : true,
  }
}


app.use(session(sessionOption));

app.use(passport.initialize());
app.use(passport.session());

passport.use(new LocalStrategy(user.authenticate()));

passport.serializeUser(user.serializeUser());
passport.deserializeUser(user.deserializeUser());

app.use((req,res,next) =>{
  res.locals.currUser = req.user;
  next();
});

app.use("/user",userRouter);

app.get("/",(req,res) =>{
    res.send("crud app!!");
    
});

app.get("/error",(req,res) =>{
  res.send("something went wrong!!");
  
});

app.listen(9000,(req,res) =>{
    console.log("app is listening to port 9000 crudApp humaira");
});