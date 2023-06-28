const mongoose = require("mongoose");

const UserSeatSchema = new mongoose.Schema({
    seatId:{
        type: String,
    },
    fullname:{
        type: String,
    },
    phone:{
        type: String,
    }
})
const UserSeat = mongoose.model("userSeat", UserSeatSchema);
module.exports = UserSeat;