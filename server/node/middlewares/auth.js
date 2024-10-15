const auth = (req, res, next) => {
    // Always allow the request to proceed
    next();
  };
  
export default auth;