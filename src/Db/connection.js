const mongoose = require("mongoose");
mongoose.connect("mongodb://127.0.0.1:27017/MovieTicket",{
  useNewUrlParser: true,
  useUnifiedTopology: true,
  
  }).then(()=>{
    console.log("connected success db");
  }).catch((e)=>{
    console.log(e);
  })
  