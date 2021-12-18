import mongoose from 'mongoose';

import modelPost from './models/Post';
import modelUser from './models/User';

const container = 'mongo';
const port = '27017';
const database = 'db';
const mongoURI = `mongodb://${process.env.DB_CONTAINER || container}:${
  process.env.DB_PORT || port
}/${process.env.DB_NAME || database}`;

export const db = mongoose.connect(mongoURI, {
  useNewUrlParser: true,
  useUnifiedTopology: true,
  // useFindAndModify: false,
  // useCreateIndex: true,
});

db.then(() => console.log(`Connected to mongo at: ${mongoURI}`)).catch(
  (error) => {
    console.error(
      `There was a problem connecting to mongo at: ${mongoURI}`,
      error,
    );
  },
);

export const User = mongoose.model('User', modelUser);
export const Post = mongoose.model('Post', modelPost);
