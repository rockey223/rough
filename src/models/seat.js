const mongoose = require("mongoose");

const seatSchema = new mongoose.Schema({
  movieId: {
    type: String,
  },
 
  seats: [{
  
      type: String,
   
   
  }],
});

seatSchema.statics.findByMovieId = function (movieId) {
  return this.find({ movieId: movieId });
};



const Seat = mongoose.model("Seat", seatSchema);

module.exports = Seat;
