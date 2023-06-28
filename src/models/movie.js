const mongoose = require("mongoose")

const movieSchema = new mongoose.Schema({
    name:{
        type:String,
    },
    releaseDate:{
        type:String,
    },
    image:{
        // data:Buffer,
        // contentType: String
        type: String,
    },
    description:{
        type: String
    },
    genre:{
        type:String
    },
    censor:{
        type:String
    }

     
})

const movie = new mongoose.model("movie",movieSchema);

module.exports = movie;