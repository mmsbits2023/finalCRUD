module.exports.isLoggedin = (req,res,next) => {
    if(!req.isAuthenticated()){
        //redirect
        req.session.redirectUrl = req.originalUrl;
   return res.json({message:"you must be login first"})
}   
next();
};

module.exports.saveRedirectUrl = (req,res,next) => {
    if(req.session.redirectUrl){
        res.locals.redirectUrl = req.session.redirectUrl;
    }
    next();
};