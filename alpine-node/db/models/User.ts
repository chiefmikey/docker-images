import mongoose from 'mongoose';

const modelUser = new mongoose.Schema({
  id: mongoose.ObjectId,
  name: String,
  email: String,
  address: String,
  pic: String,
  age: { type: Number, min: 18, max: 65 },
  hometown: String,
  occupation: String,
});

export default modelUser;
