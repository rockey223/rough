const express = require("express");
const cors = require("cors");
const multer = require("multer");
const fs = require("fs");

require("./Db/connection");
const movie = require("./models/movie");
const User = require("./models/user");
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
    if (req.body.password != req.body.confirmPassword) {
      res.status(400).send("password must be same");
    } else {
      const createUser = await user.save();
      res.status(200).send("Signed up");
    }
  } catch (e) {
    res.status(400).send(e);
  }
});

app.post("/login", async (req, res, next) => {
  console.log(req.body);
  const { email, password } = req.body;

  if (!email || !password) {
    return next (console.log("enter email and password"));
  }
  const user = await User.findOne({ email: email }).select("+password");

  if (!user) {
   return next (console.log("Invalid email or password"));
  }
  const isPasswordMatch = await user.comparePassword(password);

  if (!isPasswordMatch) {
    return next(console.log("invalid password"));
  }

  res.send("logged in");
});

app.post("/upload", (req, res) => {
  upload(req, res, (err) => {
    if (err) {
      console.log(err);
    } else {
      // console.log(req)
      const newMovie = new movie({
        name: req.body.name,
        releaseDate: req.body.releaseDate,
        image: `http://localhost:8000/uploads/${req.file.filename}`,
      });
      newMovie
        .save()
        .then(() => res.send("upload sucess"))
        .catch((err) => console.log(err));
    }
  });
});

app.get("/movie", async (req, res) => {
  try {
    const MovieList = await movie.find();
    res.json(MovieList);
  } catch (e) {
    res.status(400).send(e);
  }
});

app.get("/user", async (req, res) => {
  try {
    const userList = await User.find();
    res.json(userList);
  } catch (e) {
    res.status(400).send(e);
  }
});

app.listen(port, () => {
  console.log(`connected to ${port}`);
});
