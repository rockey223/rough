const mongoose = require("mongoose");

const UserSeatSchema = new mongoose.Schema({
    
    fullname:{
        type: String,
    },
    phone:{
        type: String,
    },
    email:{
        type:String,
    },
    userReservedSeat:[{
  
        type: String,
     
     
    }]
})
const UserSeat = mongoose.model("userSeat", UserSeatSchema);
module.exports = UserSeat;