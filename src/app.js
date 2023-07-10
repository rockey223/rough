const express = require("express");
const cors = require("cors");
const multer = require("multer");
const fs = require("fs");

require("./Db/connection");
const movie = require("./models/movie");
const User = require("./models/user");
const Seat = require("./models/seat");
const UserSeat = require("./models/UserSeat");
const app = express();
const port = process.env.PORT || 8000;
app.use(cors());
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use("/uploads", express.static("uploads"));

// storage
const Storage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, "uploads");
  },
  filename: (req, file, cb) => {
    console.log(file);
    cb(null, Date.now() + file.originalname);
  },
});

const upload = multer({
  storage: Storage,
}).single("image");

app.post("/signup", async (req, res) => {
  try {
    const user = new User(req.body);
    console.log(req.body);
    if (req.body.password != req.body.confirmPassword) {
      res.status(400).send("Both Password field must be same");
    } else {
      const createUser = await user.save();
      res.status(200).send("Signed up");
    }
  } catch (e) {
    res.status(400).send(e);
  }
});




app.post("/register", async (req, res) => {
  try {
    // const useSeat = new UserSeat(req.body);
    const { fullname, phone, email, userReservedSeat } = req.body;
    console.log(req.body); 
    const userseat = new UserSeat({
      fullname,
      phone,
      email,
      userReservedSeat
    });
    
      const registerUser = await userseat.save();
      res.status(200).send("register");
   
  } catch (e) {
    console.log(e)
    res.status(400).send(e);
  }
});



// app.post("/seat", async (req, res) => {
//   try {
//     console.log(req.body);
//     const { movieId, seats, status } = req.body;

//     const addSeats = new Seat({
//       movieId,
//       seats,
//     });
//     const reserve = await addSeats.save();

//     res.status(200).send("seat reserved");
//     // console.log(res)
//   } catch (e) {
//     console.log(e);
//   }
// });

app.patch("/seat/movie/:movieId", async (req, res) => {
  console.log(req.body);
  var ida = "";
  try {
    const movieSeat = await Seat.findByMovieId(req.params.movieId);
    if (!movieSeat) {
      const { movieId, seats } = req.body;

      const addSeats = new Seat({
        movieId,
        seats,
      });
      const reserve = await addSeats.save();

      res.status(200).send("seat reserved");
    } else {
      const { ida, movieId, seats } = req.body;
      // ida = id;
      const patchSeat = {
        movieId,
        seats,
      };
      await Seat.findByIdAndUpdate({ _id: ida }, { $set: patchSeat });
      res.status(200).json({
        success: true,
        message: "seat updated successfully!",
      });
      console.log(req.body);
    }

    // console.log(res)
  } catch (e) {
    console.log(e);
  }
});

// paisdfasdfg
app.post("/seat/movie/:movieId", async (req, res) => {
  try {
    console.log(req.body);
    const { movieId, seats } = req.body;

    const addSeats = new Seat({
      movieId,
      seats,
    });
    const reserve = await addSeats.save();

    res.status(200).send("seat reserved");
    // console.log(res)
  } catch (e) {
    console.log(e);
  }
});

app.get("/seats", async (req, res) => {
  try {
    const seatList = await Seat.find();
    res.status(200).json(seatList);
  } catch (e) {
    res.status(400).send(e);
  }
});

app.get("/seat/movie/:movieId", async (req, res, next) => {
  try {
    const seats = await Seat.findByMovieId(req.params.movieId);

    if (seats.length === 0) {
      return next(res.status(400).send("No seats found for the movie"));
    }

    res.status(200).json({
      success: true,
      message: "Seats found successfully!",
      data: seats,
    });
  } catch (e) {
    res.status(500).send("Internal server error");
    console.log(e);
  }
});

// akbflhankl avla 98v an a' AM V0I

// app.get("/seat/:id",async (req, res,next) => {
//   // console.log(req.body)
//   try{

//     const singleseat = await Seat.findByMovieId(req.params.id);
//     if (!singleseat) {
//       return next (res.status(400).send("Move not found"));
//     }
//     console.log(singleseat)
//     res.status(200).json({
//       success: true,
//       message: "Movie found successfully!",
//       data: singleseat,
//     });
//   }catch(e){
//     res.status(404).send(e);
//     console.log(e)
//   }
// });

app.post("/reserveSeat", async (req, res) => {
  try {
    console.log(req.body);
    const reserve = await UserSeat.save();
    res.status(200).send("reserved");
  } catch (e) {
    res.status(400).send(e);
  }
});

app.post("/login", async (req, res, next) => {
  console.log(req.body);
  const { email, password } = req.body;

  if (!email || !password) {
    return next(res.status(400).send("enter email and password"));
  }
  const user = await User.findOne({ email: email }).select("+password");

  if (!user) {
    return next(res.status(404).send("invalid email or password"));
  }
  const isPasswordMatch = await user.comparePassword(password);

  if (!isPasswordMatch) {
    return next(res.status(400).send("invalid password"));
  }

  res.send("logged in");
});

app.post("/upload", (req, res) => {
  upload(req, res, (err) => {
    if (err) {
      req.status(400).send(err);
    } else {
      // console.log(req)
      const newMovie = new movie({
        name: req.body.name,
        releaseDate: req.body.releaseDate,
        image: `/uploads/${req.file.filename}`,
        description: req.body.description,
        genre: req.body.genre,
        censor: req.body.censor,
      });
      newMovie
        .save()

        .then(() => res.status(200).send("upload sucess"))
        .catch((err) => res.status(400).send(err));
    }
  });
});

app.get("/movie", async (req, res) => {
  try {
    const MovieList = await movie.find();
    res.status(200).json(MovieList);
  } catch (e) {
    res.status(400).send(e);
  }
});

app.get("/user", async (req, res) => {
  try {
    const userList = await User.find();
    res.status(200).json(userList);
  } catch (e) {
    res.status(400).send(e);
  }
});

app.listen(port, () => {
  console.log(`connected to ${port}`);
});
