import { User, Post } from '../index.js';

export const findUser = async (input1, input2, input3) => {
  try {
    const result = await User.find({
      input1,
      input2,
      input3,
    });
    return JSON.stringify(result);
  } catch (error) {
    console.error(error);
    return error;
  }
};

export const findPost = async (input1, input2, input3) => {
  try {
    const result = await Post.find({
      input1,
      input2,
      input3,
    });
    return JSON.stringify(result);
  } catch (error) {
    console.error(error);
    return error;
  }
};
