const mongoose = require("mongoose");
const bcrypt = require("bcryptjs");


const userSchema = new mongoose.Schema({
    name:{
        type:String
    },
    username:{
        type:String
    },
    email:{
        type: String
    },
    password:{
        type: String
    },
    confirmPassword:{
        type:String
    }

});

userSchema.pre("save", async function (next) {
    if (!this.isModified("password")) {
      next();
    }
  
    this.password = await bcrypt.hashSync(this.password, 14);
    this.confirmPassword = await bcrypt.hashSync(this.confirmPassword,14);
  });


  
userSchema.methods.comparePassword = async function(enteredPassword){
    return await bcrypt.compare(enteredPassword, this.password);
}

const user = new mongoose.model("user",userSchema);
module.exports = user;